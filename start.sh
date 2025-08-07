#!/bin/bash

# Exit script if any command fails
set -e

echo "Starting Jekyll development server with live reload..."

# Kill any existing Jekyll processes
kill_existing_processes() {
  echo "Checking for existing Jekyll processes..."
  if ps aux | grep "[j]ekyll serve" > /dev/null; then
    echo "Killing existing Jekyll processes..."
    pkill -f "jekyll serve" || true
  fi
}

# Check if we have network connectivity
check_network() {
  echo "Checking network connectivity..."
  if timeout 3 ping -c 1 github.com &> /dev/null; then
    echo "✅ Network connection available"
    return 0  # Network available
  else
    echo "📴 No network connection detected"
    return 1  # No network
  fi
}

# Load Ruby environment from install.sh setup
load_ruby_env() {
  if [ -f ".jekyll_env" ]; then
    echo "Loading Ruby environment..."
    source .jekyll_env
  else
    echo "❌ Environment not set up. Please run './install.sh' first."
    exit 1
  fi
}

# Verify dependencies are installed
verify_dependencies() {
  if [ ! -d "vendor/bundle" ]; then
    echo "❌ Dependencies not found. Please run './install.sh' first."
    exit 1
  fi

  if ! command -v bundle &> /dev/null; then
    echo "❌ Bundler not found. Please run './install.sh' first."
    exit 1
  fi

  echo "✅ Dependencies verified"
}

# Determine which configuration to use
determine_config() {
  if check_network; then
    # Online - use regular config with remote theme
    JEKYLL_CONFIG="_config.yml"
    echo "🌐 Using online configuration with remote theme"
  else
    # Offline - check if offline config exists
    if [ -f "_config_offline.yml" ]; then
      JEKYLL_CONFIG="_config_offline.yml"
      echo "📴 Using offline configuration"
    else
      echo "❌ No network and offline config not found."
      echo "Please run './install.sh' while connected to the internet to set up offline mode."
      exit 1
    fi
  fi
}

# Clean previous build to ensure all content is fresh
clean_previous_build() {
  echo "Cleaning previous build artifacts..."
  if [ -d "_site" ]; then
    rm -rf _site
  fi
}

# Parse command line arguments
OFFLINE_MODE=false
PORT="4000"  # Default port

while getopts "p:o" opt; do
  case $opt in
    p) PORT="$OPTARG"
    ;;
    o) OFFLINE_MODE=true
    ;;
    \?) echo "Usage: $0 [-p port] [-o]"
        echo "  -p port    Specify port number (default: 4000)"
        echo "  -o         Force offline mode"
        exit 1
    ;;
  esac
done

# Run startup sequence
kill_existing_processes
load_ruby_env
verify_dependencies
clean_previous_build

# Force offline mode if requested
if [ "$OFFLINE_MODE" = true ]; then
  if [ -f "_config_offline.yml" ]; then
    JEKYLL_CONFIG="_config_offline.yml"
    echo "🔒 Forced offline mode enabled"
  else
    echo "❌ Offline mode requested but offline config not found."
    echo "Please run './install.sh' first to set up offline mode."
    exit 1
  fi
else
  determine_config
fi

# Build and serve the site with enhanced watching and reloading
echo ""
echo "🚀 Starting Jekyll server on port $PORT..."
echo "📁 Using configuration: $JEKYLL_CONFIG"
echo "🔗 Server will be available at: http://localhost:$PORT"
echo "🔄 Live reload will be available at: http://localhost:$((PORT + 1000))"
echo ""

# Start Jekyll with the determined configuration
bundle exec jekyll serve \
  --config "$JEKYLL_CONFIG" \
  --port "$PORT" \
  --livereload-port "$((PORT + 1000))" \
  --force_polling \
  --watch \
  --incremental \
  --host 0.0.0.0

echo ""
echo "Note: If you encounter any issues:"
echo "  - Run './install.sh' to reinstall dependencies"
echo "  - Use './start.sh -o' to force offline mode"
echo "  - Use './start.sh -p 3000' to change port"
