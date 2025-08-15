# AI-Powered Application Installer

A robust installer script that properly handles Python applications with relative imports.

## 🚀 Quick Start

```bash
# Download and run the installer
curl -sSL https://raw.githubusercontent.com/dfultonthebar/ai-powered-installer/main/install.sh | bash
```

Or clone and run manually:

```bash
git clone https://github.com/dfultonthebar/ai-powered-installer.git
cd ai-powered-installer
chmod +x install.sh
./install.sh
```

## ✨ Features

- **Proper Module Handling**: Uses `python -m app.main` instead of `python app/main.py` to correctly handle relative imports
- **Automatic Setup**: Creates complete application structure with proper Python package layout
- **Desktop Integration**: Creates desktop entry for easy access
- **Error Handling**: Robust error checking and user-friendly messages
- **Cross-Platform**: Works on Linux, macOS, and Windows (with WSL)

## 🔧 Technical Details

### The Relative Import Fix

The key improvement in this installer is the launcher command:

**❌ Old (problematic) approach:**
```bash
python app/main.py  # Causes ImportError with relative imports
```

**✅ New (correct) approach:**
```bash
python -m app.main  # Properly handles relative imports as a module
```

### Why This Matters

When Python files use relative imports like:
```python
from . import models
from . import utils
```

Running the file directly with `python app/main.py` treats it as a script, not a module, causing `ImportError: attempted relative import with no known parent package`.

Using `python -m app.main` tells Python to treat `app` as a package and `main` as a module within that package, allowing relative imports to work correctly.

## 📁 Application Structure

The installer creates this structure:

```
~/ai-app/
├── app/
│   ├── __init__.py      # Package initialization
│   ├── main.py          # Main application with relative imports
│   ├── models.py        # Data models and configuration
│   └── utils.py         # Utility functions
├── requirements.txt     # Python dependencies
└── launch.sh           # Launcher script (uses python -m)
```

## 🚀 Usage

After installation:

```bash
# Method 1: Use the launcher script
cd ~/ai-app && ./launch.sh

# Method 2: Run directly as module
cd ~/ai-app && python3 -m app.main
```

## 🛠️ For Existing Installations

If you have an existing installation with the old launcher, you can fix it immediately:

```bash
# Navigate to your app directory
cd ~/ai-app

# Update the launcher script
sed -i 's/python3 app\/main.py/python3 -m app.main/g' launch.sh

# Or run directly with the correct command
python3 -m app.main
```

## 🔍 Troubleshooting

### ImportError: attempted relative import with no known parent package

This error occurs when:
- Running `python app/main.py` directly
- The application uses relative imports (`from . import ...`)

**Solution**: Always use `python -m app.main` from the parent directory.

### ModuleNotFoundError: No module named 'app'

This error occurs when:
- Running `python -m app.main` from the wrong directory
- The `app` directory doesn't contain `__init__.py`

**Solution**: Ensure you're in the directory containing the `app` folder and that `app/__init__.py` exists.

## 📋 Requirements

- Python 3.6 or higher
- pip3 (for dependency installation)
- Git (for cloning the repository)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the installer thoroughly
5. Submit a pull request

## 📄 License

This project is open source and available under the MIT License.

## 🎯 Key Takeaways

- **Always use `python -m module.name` for applications with relative imports**
- **Proper package structure with `__init__.py` files is essential**
- **Test both installation and execution in clean environments**
- **Provide clear error messages and troubleshooting guidance**

---

*This installer demonstrates best practices for Python application deployment and module handling.*
