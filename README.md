# ShiftKit

A modular Ubuntu system recovery and configuration tool.

## Overview

ShiftKit helps you quickly recover your Ubuntu installation by automating the installation of packages, software, and restoring your configurations. It's designed to be modular, allowing you to easily add or modify components as needed.

## Features

- Modular architecture for easy extension
- Package installation from apt and other sources
- Software installation (Steam, Windsurf, Neovim, Node, Python, Ghostty, Telegram, Solaar, etc.)
- Configuration restoration (bashrc, tiling manager, rice items)
- System settings configuration
- Driver installation and configuration
- Beautiful progress bar similar to apt
- Customizable execution order via configuration

## Usage

```bash
./construct.sh [options]
```

Options:
- `--config <file>`: Use a custom configuration file
- `--module <module>`: Run only specific module(s)
- `--list-modules`: List available modules
- `--help`: Show help message

## Configuration

Edit `config.yaml` to customize which modules to run and in what order.

## Adding New Modules

Create a new module in the `modules/` directory. See existing modules for examples.
