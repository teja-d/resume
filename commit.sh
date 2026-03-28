cp resume.tex resume_$1.tex
#!/usr/bin/env bash
set -euo pipefail

company="${1:-}"
if [ -z "$company" ]; then
	echo "Usage: $0 <company>" >&2
	exit 1
fi

# create a copy for the specified company
cp -v resume.tex "resume_${company}.tex"

# stage and commit only the copied file
git add "resume_${company}.tex" prompt-101 commit.sh
git commit -m "new resume ${company}"
git push

# restore resume.tex to the HEAD version to rollback local changes
if git rev-parse --verify HEAD >/dev/null 2>&1; then
	git checkout -- resume.tex
else
	echo "No commits in repository; skipping restore of resume.tex" >&2
fi