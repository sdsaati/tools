# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command

# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!
class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the *currently selected file*.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()

############################## SDSAATI #######################################
class fzf_select(Command):
    """
    :fzf_select
    Find a file using fzf.
    With a prefix argument to select only directories.

    See: https://github.com/junegunn/fzf
    """

    def execute(self):
        import subprocess
        import os
        from ranger.ext.get_executables import get_executables

        if 'fzf' not in get_executables():
            self.fm.notify('Could not find fzf in the PATH.', bad=True)
            return

        fd = None
        if 'rg' in get_executables():
            fd = 'rg'
        # elif 'fdfind' in get_executables():
        #     fd = 'fdfind'
        # elif 'fd' in get_executables():
        #     fd = 'fd'

        if fd is not None:
            hidden = ('--hidden' if self.fm.settings.show_hidden else '')
            exclude = "--glob \"!.*__pycache__/*\" --glob \"!venv/*\" --glob \"!.venv/*\" --glob \"!.git/*\""
            only_directories = ('--type directory' if self.quantifier else '')
            fzf_default_command = '{} --files {} --smart-case --follow {} {} --color=always'.format(
                fd, hidden, exclude, only_directories
            )
        env = os.environ.copy()
        env['FZF_DEFAULT_COMMAND'] = fzf_default_command
        env['FZF_DEFAULT_OPTS'] = "--preview 'batcat --color=always {}'" 

        fzf = self.fm.execute_command('fzf', universal_newlines=True, stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected = os.path.abspath(stdout.strip())
            if os.path.isdir(selected):
                self.fm.cd(selected)
            else:
                self.fm.select_file(selected)



class MyStatusBar(Command):
    def execute(self):
        # Get custom information
        custom_info = "My Custom Information"

        # Set the status bar
        self.fm.statusbar[1].update_content(custom_info)


class extract(Command):
    """:extract <filename>

    extract a tar.gz or .tar or .zip file
    """

    def execute(self):
        import subprocess
        env = os.environ.copy()
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            inputFiles = self.rest(1)
        else:
            # reference to the *currently selected file*.
            inputFiles = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Extracting " + inputFiles + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(inputFiles):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # run "pydoc ranger.core.actions" for a list.
        folder = self.arg(1)[:-3]
        self.fm.mkdir(folder)
        result = self.fm.execute_command('tar -xvf ' + inputFiles + ' --directory="'+folder+'"',env=env, stdout=subprocess.PIPE)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()


class zip(Command):
    """:extract <filename>

    It's one of the most good compression algorithms
    Creates a .tar.xz file
    """

    def execute(self):
        import subprocess
        env = os.environ.copy()
        if self.arg(1):
            outputFile = self.arg(1) + ".tar.xz"
            inputFiles = self.rest(1)
            self.fm.notify(inputFiles)
        else:
            return
        #self.fm.notify("The given file does not exist!", bad=True)
        # run "pydoc ranger.core.actions" for a list.
        result = self.fm.execute_command('tar -caf "' + outputFile + '" ' + inputFiles, env=env, stdout=subprocess.PIPE)
        return

    def tab(self, tabnum):
        return self._tab_directory_content()


class tar(Command):
    """:extract <filename>

    Tar is not compressed! it's just bundles some files to one file
    Creates a .tar file
    """

    def execute(self):
        import subprocess
        env = os.environ.copy()
        if self.arg(1):
            outputFile = self.arg(1) + ".tar"
            inputFiles = self.rest(1)
            self.fm.notify(inputFiles)
        else:
            return
        result = self.fm.execute_command('tar -caf "' + outputFile + '" ' + inputFiles, env=env, stdout=subprocess.PIPE)
        return
    def tab(self, tabnum):
        return self._tab_directory_content()


