## Digital poster prototypes

## Get started

### Step 1: 

##### Setup git
You can skip this step if you already have git installed.

#### Windows: [Git for windows](https://gitforwindows.org/)
#### MacOS: [Installing git on a mac](https://gist.github.com/derhuerst/1b15ff4652a867391f03#installing-git-on-a-mac)

### Step 2:

##### Download the repository to your local computer

1. Open your terminal
2. Find a location you want to save the repository (check 'Bash commands' for help)
3. Enter `git clone git@github.com:niiicolai/digital-poster-prototypes.git` to download the repository

You should now have downloaded a directory called `digital-poster-prototypes` and be ready to work in this repository.

## How to:

##### Develop on your local machine

- When you enter the directory `digital-poster-prototypes` for the first time, you will be on the master branch.
- The master branch is the main branch. This branch should be kept clean from experimental code and unready bug fixes.
- You will therefore need to create a new local branch where you do your modifications.
- To create a new branch: Enter `git checkout -b <branch-name>` in your terminal
- Use `git checkout <branch-name>` without the -b option to switch between branches

##### Push and merge a local branch to master

1. Ensure you are on the correct branch. Use either `git branch` or `git status` to confirm.
2. Use `git add path/file` for a singular file or `git add .` to add all files to a commit
3. Use `git push origin <branch-name>` to push the changes to Github
4. Go to [the current repository](https://github.com/niiicolai/digital-poster-prototypes) and click on `compare & pull request` in the top
5. Assign the pull request to another member for review or click `Merge pull request` to merge instantly

[Example of a pull request](https://github.com/niiicolai/digital-poster-prototypes/pull/1)

##### Where do I put my sketch folder to add a new prototype?
1. Ensure the directory name doesn't conflict with another directory name inside `digital-poster-prototypes/prototypes`
2. Ensure you checkout to another git branch (than master) before doing any modifications
3. Move your sketch folder under `digital-poster-prototypes/prototypes`
4. Follow the guidelines for 'Push and merge a local branch to master' if the prototype is done.

## Bash commands: 
- `ls` to list files and folders in the current directory 
- `mkdir <foldername>` to create a directory
- `cd <foldername>` to enter a directory

## Useful links:
- [Adding a new ssh key to your github account](https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account)
- [Basic branching and merging](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)
- [Git push](https://www.atlassian.com/git/tutorials/syncing/git-push)
