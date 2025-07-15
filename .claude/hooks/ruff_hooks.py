#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.8"
# dependencies = []
# ///

"""
Claude Code hooks for running Ruff check and format after file operations.
This script should be saved as ~/.claude/hooks/ruff_hooks.py
"""

import json
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
            ["ruff", "check", "--fix", filepath, "--ignore", "F401"],
            capture_output=True,
            text=True,
            timeout=30,
        )

        if result.returncode != 0:
            print(f"Ruff check warnings/errors for {filepath}:")
            if result.stdout:
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
        print("Ruff not found. Install with: uv add ruff")
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
            if result.stdout:
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
        print("Ruff not found. Install with: uv add ruff")
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
    try:
        # Read JSON input from stdin
        input_data = json.load(sys.stdin)

        # Extract tool information
        tool_name = input_data.get("tool", {}).get("name", "unknown")
        tool_input = input_data.get("tool", {}).get("input", {})

        print(f"Running Ruff hooks for {tool_name} operation...")

        # Get file paths based on the tool type
        filepaths = []

        if tool_name in ["write", "edit"]:
            # Single file operations
            filepath = tool_input.get("path")
            if filepath:
                filepaths = [filepath]
        elif tool_name == "multiedit":
            # Multi-file operations
            edits = tool_input.get("edits", [])
            for edit in edits:
                filepath = edit.get("path")
                if filepath:
                    filepaths.append(filepath)

        if not filepaths:
            print("No file paths found in input data")
            sys.exit(0)

        # Process each file
        all_success = True
        for filepath in filepaths:
            success = process_file(filepath)
            all_success = all_success and success

        if all_success:
            print("✓ All Ruff operations completed successfully")
            sys.exit(0)
        else:
            print("✗ Some Ruff operations failed")
            sys.exit(1)

    except json.JSONDecodeError:
        # Handle JSON decode errors gracefully
        print("Error: Invalid JSON input")
        sys.exit(0)
    except Exception as e:
        # Exit cleanly on any other error
        print(f"Error: {e}")
        sys.exit(0)


if __name__ == "__main__":
    main()
