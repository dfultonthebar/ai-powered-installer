#!/bin/bash

# AI-Powered Application Installer
# This script installs and sets up the AI application with proper module handling

set -e  # Exit on any error

echo "🚀 AI-Powered Application Installer"
echo "=================================="

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3 and try again."
    exit 1
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 is not installed. Please install pip3 and try again."
    exit 1
fi

# Create application directory
APP_DIR="$HOME/ai-app"
echo "📁 Creating application directory: $APP_DIR"
mkdir -p "$APP_DIR"
cd "$APP_DIR"

# Create the app module structure
echo "📦 Setting up application structure..."
mkdir -p app

# Create main application file with relative imports
cat > app/__init__.py << 'EOF'
"""AI-Powered Application Package"""
__version__ = "1.0.0"
EOF

cat > app/models.py << 'EOF'
"""Application models and data structures"""

class AppConfig:
    def __init__(self):
        self.name = "AI-Powered Application"
        self.version = "1.0.0"
        self.description = "A sample AI application with proper module structure"

def get_config():
    return AppConfig()
EOF

cat > app/utils.py << 'EOF'
"""Utility functions for the application"""

def format_message(message, prefix="INFO"):
    return f"[{prefix}] {message}"

def display_banner():
    banner = """
    ╔══════════════════════════════════════╗
    ║        AI-Powered Application        ║
    ║              Running!                ║
    ╚══════════════════════════════════════╝
    """
    print(banner)
EOF

cat > app/main.py << 'EOF'
"""Main application entry point with relative imports"""

from . import models
from . import utils

def main():
    """Main application function"""
    # Display banner
    utils.display_banner()
    
    # Get configuration
    config = models.get_config()
    
    # Display application info
    print(utils.format_message(f"Application: {config.name}"))
    print(utils.format_message(f"Version: {config.version}"))
    print(utils.format_message(f"Description: {config.description}"))
    print(utils.format_message("Application started successfully!"))
    
    # Simulate some work
    import time
    print(utils.format_message("Processing..."))
    time.sleep(2)
    print(utils.format_message("Application completed successfully!", "SUCCESS"))

if __name__ == "__main__":
    main()
EOF

# Create requirements.txt
cat > requirements.txt << 'EOF'
# Add your Python dependencies here
# For example:
# requests>=2.25.0
# numpy>=1.21.0
EOF

# Install dependencies (if any)
echo "📦 Installing Python dependencies..."
if [ -s requirements.txt ]; then
    pip3 install -r requirements.txt
else
    echo "ℹ️  No dependencies to install"
fi

# Create launcher script with correct module execution
echo "🔧 Creating launcher script..."
cat > launch.sh << 'EOF'
#!/bin/bash

# AI Application Launcher
# Uses python -m to properly handle relative imports

cd "$(dirname "$0")"

echo "🚀 Starting AI-Powered Application..."

# Use python -m to run as module, which handles relative imports correctly
python3 -m app.main

echo "✅ Application finished."
EOF

# Make launcher executable
chmod +x launch.sh

# Create desktop entry (optional)
DESKTOP_FILE="$HOME/.local/share/applications/ai-app.desktop"
mkdir -p "$(dirname "$DESKTOP_FILE")"
cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=AI-Powered Application
Comment=Launch the AI-Powered Application
Exec=$APP_DIR/launch.sh
Icon=applications-development
Terminal=true
Categories=Development;
EOF

echo ""
echo "✅ Installation completed successfully!"
echo ""
echo "📍 Application installed in: $APP_DIR"
echo "🚀 To run the application:"
echo "   cd $APP_DIR && ./launch.sh"
echo ""
echo "🖥️  Or run directly with: python3 -m app.main (from $APP_DIR)"
echo ""
echo "📱 A desktop entry has been created for easy access."
echo ""
echo "🎉 Enjoy your AI-Powered Application!"
