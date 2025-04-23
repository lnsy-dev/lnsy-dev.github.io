#!/bin/bash

# Set up Ruby environment
echo "Setting up Ruby environment..."

# Add Ruby from Homebrew to path
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"

# Save environment variables to shell configuration
if [[ "$SHELL" == *"zsh"* ]]; then
  SHELL_CONFIG="$HOME/.zshrc"
else
  SHELL_CONFIG="$HOME/.bash_profile"
fi

echo "Adding Ruby environment to $SHELL_CONFIG"

# Check if config already has these settings
if ! grep -q "# Ruby environment" "$SHELL_CONFIG"; then
  cat << 'EOF' >> "$SHELL_CONFIG"

# Ruby environment for Jekyll
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"
EOF
fi

# Install required gems
echo "Installing required gems..."
gem install bundler
bundle install

echo "Ruby environment setup complete!"
echo "Please restart your terminal or run 'source $SHELL_CONFIG' to apply the changes."
echo "Then you can use 'bundle exec jekyll serve' to start your Jekyll site." 