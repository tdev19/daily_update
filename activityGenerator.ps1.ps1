# Set up your name and email if not done already
git config user.name "tdev19"
git config user.email "dvthuse07@gmail.com"

# Loop for 30 days
for ($i = 300; $i -lt 600; $i++) {

    # Generate a random number between 0 and 100
    $randomNumber = Get-Random -Minimum 0 -Maximum 5
    Write-Output $randomNumber
    $n  = $i + $randomNumber
    $daysAgo = (Get-Date).AddDays(-$n)
    Write-Output $daysAgo
    $commitDate = $daysAgo.ToString("yyyy-MM-ddTHH:mm:ss")

    # Modify a dummy file
    Add-Content -Path "activity.txt" -Value "Commit made on $commitDate"

    # Stage the file
    git add activity.txt

    # Commit with backdated author and committer date
    $env:GIT_AUTHOR_DATE = $commitDate
    $env:GIT_COMMITTER_DATE = $commitDate
    git commit -m "Commit on $($commitDate)"

    # Clear the environment variables after commit
    Remove-Item Env:\GIT_AUTHOR_DATE
    Remove-Item Env:\GIT_COMMITTER_DATE
}

# Push to GitHub
git push 