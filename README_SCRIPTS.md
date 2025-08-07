# Jekyll Development Scripts

This repository includes two scripts to manage your Jekyll development environment: `install.sh` for one-time setup and `start.sh` for starting the development server.

## Quick Start

```bash
# First time setup (requires internet connection)
./install.sh

# Start the development server
./start.sh
```

## Scripts Overview

### `install.sh` - One-time Setup

This script sets up your Jekyll development environment and only needs to be run once (or when dependencies change).

**What it does:**
- Installs Ruby via Homebrew (if not already installed)
- Sets up gem paths and environment variables
- Installs the correct version of Bundler (matching Gemfile.lock)
- Installs all Jekyll dependencies locally in `vendor/bundle`
- Downloads and caches the remote theme for offline use
- Creates an offline configuration file
- Creates environment configuration for start.sh
- Performs an initial build to cache all assets

**Requirements:**
- Internet connection (for downloading dependencies and theme)
- Homebrew (will prompt to install if missing)

**Run this when:**
- First time setting up the project
- Dependencies in Gemfile have changed
- You want to update the cached theme

### `start.sh` - Development Server

This script starts the Jekyll development server and can work both online and offline.

**What it does:**
- Loads the Ruby environment
- Verifies dependencies are installed
- Detects network connectivity automatically
- Uses appropriate configuration (online vs offline)
- Starts Jekyll with live reload and file watching

**Usage:**
```bash
# Start server (auto-detects online/offline)
./start.sh

# Start on a different port
./start.sh -p 3000

# Force offline mode (even when online)
./start.sh -o

# Force offline mode on different port
./start.sh -o -p 3000
```

## Online vs Offline Mode

### Online Mode
- Uses `_config.yml` with remote theme
- Downloads theme from GitHub if needed
- Full functionality with latest theme updates

### Offline Mode
- Uses `_config_offline.yml` with local theme copy
- No network requests
- Works completely offline after initial setup

The scripts automatically detect your network status and choose the appropriate mode.

## Configuration Files

### `_config.yml`
- Main configuration file
- Uses `remote_theme: riggraz/no-style-please`
- Requires internet connection

### `_config_offline.yml`
- Created by `install.sh`
- Uses local theme: `theme: no-style-please`
- Works without internet connection
- Mirrors all settings from main config

### `.jekyll_env`
- Created by `install.sh`
- Contains environment variables for Ruby/Gem paths
- Sourced by `start.sh`

## Troubleshooting

### "Environment not set up" error
```bash
# Run install script first
./install.sh
```

### "Dependencies not found" error
```bash
# Re-run installation
./install.sh
```

### Network connection issues
```bash
# Force offline mode
./start.sh -o
```

### Theme not loading properly
```bash
# Re-run install to refresh theme cache
./install.sh
```

### Port already in use
```bash
# Use a different port
./start.sh -p 4001
```

### Permission errors
```bash
# Ensure scripts are executable
chmod +x install.sh start.sh
```

## Development Workflow

1. **Initial Setup** (one time, online):
   ```bash
   ./install.sh
   ```

2. **Daily Development** (works offline):
   ```bash
   ./start.sh
   ```

3. **Update Dependencies** (when needed, online):
   ```bash
   ./install.sh
   ```

## File Structure

After running `install.sh`, your directory will include:

```
├── _config.yml              # Main configuration
├── _config_offline.yml      # Offline configuration (generated)
├── .jekyll_env              # Environment variables (generated)
├── .jekyll-cache/           # Jekyll cache directory
├── vendor/bundle/           # Local gem dependencies
├── install.sh               # Setup script
├── start.sh                 # Development server script
└── ...                      # Your Jekyll site files
```

## Notes

- The `vendor/bundle/` directory contains all your gems locally
- The `.jekyll-cache/` directory contains cached theme files
- Both cache directories can be safely deleted - they'll be recreated by `install.sh`
- The scripts work on macOS and Linux (requires Homebrew on macOS)
- Network detection uses a quick ping to GitHub - adjust timeout if needed