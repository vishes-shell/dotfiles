#!/usr/bin/env python3
"""
Claude Code hooks for running Ruff check and format after file operations.
This script should be saved as a hook file in your Claude Code hooks directory.
"""

import subprocess
import sys
import os


def is_python_file(filepath):
    """Check if the file is a Python file."""
    return filepath.endswith(".py") or filepath.endswith(".pyi")


def run_ruff_check(filepath):
    """Run ruff check --fix on the specified file."""
    try:
        result = subprocess.run(
            ["ruff", "check", "--fix", filepath],
            capture_output=True,
            text=True,
            timeout=30,
        )

        if result.returncode != 0:
            print(f"Ruff check warnings/errors for {filepath}:")
            print(result.stdout)
            if result.stderr:
                print(result.stderr)
        else:
            print(f"✓ Ruff check passed for {filepath}")

        return result.returncode == 0

    except subprocess.TimeoutExpired:
        print(f"Ruff check timed out for {filepath}")
        return False
    except FileNotFoundError:
        print("Ruff not found. Install with: pip install ruff")
        return False
    except Exception as e:
        print(f"Error running ruff check: {e}")
        return False


def run_ruff_format(filepath):
    """Run ruff format on the specified file."""
    try:
        result = subprocess.run(
            ["ruff", "format", filepath], capture_output=True, text=True, timeout=30
        )

        if result.returncode != 0:
            print(f"Ruff format failed for {filepath}:")
            print(result.stdout)
            if result.stderr:
                print(result.stderr)
        else:
            print(f"✓ Ruff format completed for {filepath}")

        return result.returncode == 0

    except subprocess.TimeoutExpired:
        print(f"Ruff format timed out for {filepath}")
        return False
    except FileNotFoundError:
        print("Ruff not found. Install with: pip install ruff")
        return False
    except Exception as e:
        print(f"Error running ruff format: {e}")
        return False


def process_file(filepath):
    """Process a single file with Ruff check and format."""
    if not os.path.exists(filepath):
        print(f"File not found: {filepath}")
        return False

    if not is_python_file(filepath):
        print(f"Skipping non-Python file: {filepath}")
        return True

    print(f"Processing {filepath}...")

    # Run ruff check --fix first
    check_success = run_ruff_check(filepath)

    # Run ruff format
    format_success = run_ruff_format(filepath)

    return check_success and format_success


def main():
    """Main hook function called by Claude Code."""
    # Get the operation type from environment variable or command line
    operation = os.getenv("CLAUDE_OPERATION", "unknown")

    if len(sys.argv) < 2:
        print("Usage: ruff_hooks.py <filepath> [filepath2 ...]")
        sys.exit(1)

    print(f"Running Ruff hooks for {operation} operation...")

    # Process each file passed as argument
    all_success = True
    for filepath in sys.argv[1:]:
        success = process_file(filepath)
        all_success = all_success and success

    if all_success:
        print("✓ All Ruff operations completed successfully")
        sys.exit(0)
    else:
        print("✗ Some Ruff operations failed")
        sys.exit(1)


# Hook functions for different operations
def after_write(filepath):
    """Hook called after write operations."""
    os.environ["CLAUDE_OPERATION"] = "write"
    sys.argv = ["ruff_hooks.py", filepath]
    main()


def after_edit(filepath):
    """Hook called after edit operations."""
    os.environ["CLAUDE_OPERATION"] = "edit"
    sys.argv = ["ruff_hooks.py", filepath]
    main()


def after_multiedit(*filepaths):
    """Hook called after multiedit operations."""
    os.environ["CLAUDE_OPERATION"] = "multiedit"
    sys.argv = ["ruff_hooks.py"] + list(filepaths)
    main()


if __name__ == "__main__":
    main()
