from setuptools import setup, find_packages

setup(
    name="remove_cpp_comments",
    version="0.1",
    packages=find_packages(),
    entry_points={
        'console_scripts': [
            'remove-cpp-comments=hooks.remove_cpp_comments:remove_cpp_comments',
        ],
    },
)

