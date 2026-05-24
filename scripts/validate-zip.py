"""ZIP validator that mirrors Anthropic's Agent Skills upload validator.

Checks (all hard fail):
  1. Single root directory matching skill `name` from SKILL.md frontmatter
  2. All entry paths use forward slash `/` (no backslash)
  3. All entry paths are pure ASCII
  4. SKILL.md present at <root>/SKILL.md
  5. SKILL.md frontmatter parses, has `name` and `description`
  6. frontmatter `name` matches root folder
  7. No __MACOSX / .DS_Store / Thumbs.db pollution
  8. Inner SKILL.md / package.json / CHANGELOG.md version (if present) all match

Usage: python scripts/validate-zip.py [zip_path]
"""
from __future__ import annotations
import os
import re
import sys
import zipfile

DEFAULT_ZIP = "markdown-c4c-v5.1.1.zip"


def fail(msg: str) -> None:
    print(f"  [FAIL] {msg}")


def ok(msg: str) -> None:
    print(f"  [ OK ] {msg}")


def parse_frontmatter(text: str) -> dict[str, str]:
    m = re.match(r"^---\s*\n(.*?)\n---\s*\n", text, re.DOTALL)
    if not m:
        return {}
    fm = {}
    for line in m.group(1).splitlines():
        m2 = re.match(r'^([A-Za-z_-]+):\s*"?([^"#]+?)"?\s*$', line)
        if m2:
            fm[m2.group(1)] = m2.group(2).strip()
    return fm


def validate(zip_path: str) -> int:
    print(f"=== Validating {zip_path} ===\n")
    if not os.path.isfile(zip_path):
        fail(f"file not found: {zip_path}")
        return 1

    errors = 0
    zf = zipfile.ZipFile(zip_path)
    entries = zf.infolist()

    # 2. Backslash check
    bad_slash = [e.filename for e in entries if "\\" in e.filename]
    if bad_slash:
        fail(f"{len(bad_slash)} entries contain backslash")
        for n in bad_slash[:3]:
            print(f"         - {n}")
        errors += 1
    else:
        ok(f"All {len(entries)} entries use forward slash")

    # 3. ASCII check
    non_ascii = [e.filename for e in entries if not e.filename.isascii()]
    if non_ascii:
        fail(f"{len(non_ascii)} entries contain non-ASCII")
        for n in non_ascii[:3]:
            print(f"         - {n}")
        errors += 1
    else:
        ok("All entry names are pure ASCII")

    # 1. Single root folder
    roots = {e.filename.split("/", 1)[0] for e in entries}
    if len(roots) != 1:
        fail(f"Multiple root folders detected: {sorted(roots)}")
        errors += 1
        root = None
    else:
        root = next(iter(roots))
        ok(f"Single root folder: {root}/")

    # 7. Pollution check
    pollution = [
        e.filename for e in entries if any(p in e.filename for p in ("__MACOSX", ".DS_Store", "Thumbs.db"))
    ]
    if pollution:
        fail(f"Found OS pollution: {pollution[:3]}")
        errors += 1
    else:
        ok("No __MACOSX/.DS_Store/Thumbs.db pollution")

    if root is None:
        return errors

    # 4. SKILL.md exists
    skill_md_path = f"{root}/SKILL.md"
    skill_md_entry = next((e for e in entries if e.filename == skill_md_path), None)
    if skill_md_entry is None:
        fail(f"SKILL.md not found at {skill_md_path}")
        return errors + 1
    ok(f"SKILL.md present at {skill_md_path}")

    skill_md = zf.read(skill_md_entry).decode("utf-8")
    fm = parse_frontmatter(skill_md)
    if not fm:
        fail("SKILL.md frontmatter could not be parsed")
        errors += 1
        return errors

    # 5. Required frontmatter fields
    for field in ("name", "description"):
        if field not in fm:
            fail(f"SKILL.md frontmatter missing required field: {field}")
            errors += 1
        else:
            preview = fm[field][:60].replace("\n", " ")
            ok(f"frontmatter {field}: {preview!r}")

    # 6. name matches root
    if fm.get("name") and fm["name"] != root:
        fail(f"frontmatter name {fm['name']!r} != root folder {root!r}")
        errors += 1
    else:
        ok(f"frontmatter name matches root folder")

    # description length (Anthropic limit is 1024)
    desc_len = len(fm.get("description", ""))
    if desc_len > 1024:
        fail(f"description too long: {desc_len} chars (limit 1024)")
        errors += 1
    else:
        ok(f"description length: {desc_len} chars (limit 1024)")

    # 8. Version consistency
    skill_version = fm.get("version", "")
    if skill_version:
        ok(f"SKILL.md version: {skill_version}")
        # Cross-check with sibling files (outside ZIP)
        pkg_path = "package.json"
        if os.path.exists(pkg_path):
            with open(pkg_path, encoding="utf-8") as f:
                m = re.search(r'"version":\s*"([^"]+)"', f.read())
                if m:
                    if m.group(1) == skill_version:
                        ok(f"package.json version matches: {m.group(1)}")
                    else:
                        fail(f"package.json version {m.group(1)} != SKILL.md {skill_version}")
                        errors += 1
        cl_path = "CHANGELOG.md"
        if os.path.exists(cl_path):
            with open(cl_path, encoding="utf-8") as f:
                m = re.search(r"## \[([\d.]+)\]", f.read())
                if m:
                    if m.group(1) == skill_version:
                        ok(f"CHANGELOG.md top entry matches: [{m.group(1)}]")
                    else:
                        fail(f"CHANGELOG.md top {m.group(1)} != SKILL.md {skill_version}")
                        errors += 1

    # Personal info residue
    print("\n--- Personal info residue scan ---")
    patterns = ["Saroj", "kensu", "SAROJ SEENUAN", "ken@c4c", "kensunshine"]
    hits = []
    for e in entries:
        if e.filename.endswith((".md", ".json", ".css", ".yaml", ".yml")):
            try:
                text = zf.read(e).decode("utf-8", errors="replace")
            except Exception:
                continue
            for p in patterns:
                if p in text:
                    hits.append((e.filename, p))
    if hits:
        fail(f"{len(hits)} personal-info hits found:")
        for fn, p in hits[:5]:
            print(f"         - {fn}: {p!r}")
        errors += 1
    else:
        ok("Zero personal info in ZIP content")

    print(f"\nTotal entries: {len(entries)}")
    print(f"ZIP size:      {os.path.getsize(zip_path) / 1024:.1f} KB")
    print(f"\n=== {'PASSED' if errors == 0 else f'FAILED ({errors} errors)'} ===")
    return errors


if __name__ == "__main__":
    zp = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_ZIP
    sys.exit(0 if validate(zp) == 0 else 1)
