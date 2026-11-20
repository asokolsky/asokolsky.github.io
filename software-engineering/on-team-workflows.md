# Engineering Team Workflows

So you've got yourself an engineering team, agents are welcome.  What are the requirements for your team workflows?

Remember, the team mission is not just to deliver deliverables.  We also want to be a learning team so that we improve overtime.

Hence....

## Traceability

To me traceability is a single most important factor in support for [root cause analysis](https://en.wikipedia.org/wiki/Root-cause_analysis).

### Forward Traceability

Forward traceability: requirements → design → implementation → verification → deployment → ops.

In other words, for every requirement, we should be able to explain how our design delivers on it.  And then explain which part of implementation delivers on that element of the design.

Similarly, for every (Jira) issue I can identify associated pull requests, associated commits, down to a changed source code file/line.

### Reverse Traceability

Especially important to supporting root cause analysis!

You complete your slice of activities. Five years/months/weeks/hours later something goes wrong.  Or just not the way you expected.  Now you need to understand:

- why things are not going the way you expected,
- even more importantly, what in your workflows should be improved to prevent this discrepancy from reoccurring.

To answer the first question is, almost always, simple.  Here is a bug!  Here is the file and line number.  Anyone, even an agent, can do it!

The engineering team which is self-improving goes further.  We use reverse traceability to identify the root cause of the problem and that of the process failure:

- bug file and line number
- commit
- pull request
- (Jira) issue with corresponding design and requirements

If the root cause of the problem is a coder error - then just fix the defect, add a regression test where useful, and examine what allowed it to escape.

If the design was wrong - fix that AND improve design process.

Most dangerous was (mis) interpretation or gap of the requirements.

## Development Process Planning

[Agile ceremonies](https://www.atlassian.com/agile/scrum/ceremonies): Sprint planning, Daily Scrum, Sprint Review, Sprint Retrospective, Product Backlog Refinement.

## Status Communication

Ad-hoc artifacts for communication is a not-go.  For a simple reason that they are obsolete even before they are complete.

Instead: keep status in one authoritative place, e.g. issue database. Generate communication views from it, and give temporary planning artifacts an owner and an expiration.

Important: support for abstraction layers / ability to drill in.  E.g. reliability track -> observability -> specific metrics

## Managing Multiple Teams

- [Scrum-of-scrums](https://www.atlassian.com/agile/scrum/scrum-of-scrums)
- [Big Room Planning](https://www.infoq.com/articles/making-scaling-agile-work-4/)

## More

- https://en.wikipedia.org/wiki/Capability_Maturity_Model
- https://en.wikipedia.org/wiki/Five_whys
