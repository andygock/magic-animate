@echo off
rem Activate the virtual environment
call venv\Scripts\activate

rem Run the Python script inside the virtual environment
python -m demo.gradio_animate

rem Deactivate the virtual environment (optional)
deactivate