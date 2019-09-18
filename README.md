## Digital poster prototypes

## Get started

### Step 1: 

##### Setup git
You can skip this step if you already have git installed.

#### Windows: [Git for windows](https://gitforwindows.org/)
#### MacOS: [Installing git on a mac](https://gist.github.com/derhuerst/1b15ff4652a867391f03#installing-git-on-a-mac)
#### Both:
- [Visual studio Github](https://visualstudio.github.com/)
- [Github desktop](https://desktop.github.com/)

### Step 2:

##### Add a SSH key to Github
1. Check if you already have generated a SSH key [Checking for existing SSH keys](https://help.github.com/en/enterprise/2.15/user/articles/checking-for-existing-ssh-keys)
2. If you had a SSH key skip this step or follow the guidelines in [Generating a new SSH key](https://help.github.com/en/enterprise/2.15/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
3. Add the SSH key to your Github account [Adding a new SSH key to your GitHub account](https://help.github.com/en/enterprise/2.15/user/articles/adding-a-new-ssh-key-to-your-github-account)

### Step 3:

##### Download the repository to your local computer

1. Open your terminal
2. Find a location you want to save the repository (check '[Bash commands](https://github.com/niiicolai/digital-poster-prototypes#bash-commands)' for help)
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
4. Follow the guidelines for `Push and merge a local branch to master` if the prototype is done.

##### Work on the production version of the digital poster
1. Ensure you have the latest version of the master branch

Open your terminal and `git checkout master` to move to the master branch and enter `git status`,

You should see the message:
```
On branch master
Your branch is up to date with 'origin/master'
```
if everything is up to date on the master branch.

2. If your master branch was `up to date`, skip to step 3
If your local master branch was behind the remote, enter `git pull origin master`
to get the latest version of the master branch.

3. Create a new branch to work on the digital poster
Enter `git checkout -b some-branch-name` to create a new branch. (Try to find a name related to the task)
4. Open one of the `processing source code` files inside the `\Digital-poster\digtalPoster`
5. Modify the code a way that fits the current task
6. [Push and merge a local branch to master](https://github.com/niiicolai/digital-poster-prototypes#push-and-merge-a-local-branch-to-master)

## Bash commands: 
- `ls` to list files and folders in the current directory 
- `mkdir <foldername>` to create a directory
- `cd <foldername>` to enter a directory

## Useful links:
- [Why git?](https://www.atlassian.com/git/tutorials/why-git)
- [Basic branching and merging](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)
- [Git push](https://www.atlassian.com/git/tutorials/syncing/git-push)
