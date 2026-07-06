#!/usr/bin/env python3
# hermes-verify-phase3-wali.py
import subprocess, sys, os, json, pathlib

changed = [
    "lib/features/master/models/wali.dart",
    "lib/features/master/models/wali_santri.dart",
    "lib/features/master/pages/wali_form_page.dart",
    "lib/features/master/pages/wali_list_page.dart",
    "lib/features/master/provider/master_provider.dart",
    "lib/features/master/repo/wali_repo.dart",
    "lib/features/master/repo/wali_santri_repo.dart",
]

def run(cmd):
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True, cwd="D:/Arsyad/Project Mizan/pesantren_management")
    return result.returncode, result.stdout + result.stderr

# 1. Check files exist
missing = [f for f in changed if not pathlib.Path(f).exists()]
if missing:
    print("❌ Missing files:", missing)
    sys.exit(1)

# 2. Run flutter analyze
code, out = run("flutter analyze")
errors = [l for l in out.splitlines() if l.strip().startswith("error")]
warnings = [l for l in out.splitlines() if l.strip().startswith("warning")]

# 3. Run tests
test_code, test_out = run("flutter test")

print("\n=== VERIFICATION REPORT ===\n")
print(f"Files checked: {len(changed)}")
print(f"File existence: ✅ All present\n")

print("flutter analyze:")
print(f"  Errors: {len(errors)}")
print(f"  Warnings: {len(warnings)}")
if errors:
    print("  Sample errors:")
    for e in errors[:3]: print(f"    {e}")
else:
    print("  ✅ No hard errors")

print("\nflutter test:")
print(f"  Exit code: {test_code}")
print(test_out.strip() if test_out.strip() else "  ✅ Tests passed")

# Summary
if not errors and test_code == 0:
    print("\n✅ VERIFICATION PASSED")
else:
    print("\n❌ VERIFICATION FAILED")
    sys.exit(1)