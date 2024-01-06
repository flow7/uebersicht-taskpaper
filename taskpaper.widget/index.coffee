# Description: Display TaskPaper tasks based on a searchtag - and not tagged as done or archived
# Version 1.0


# Adjust the following to your liking!
todolistfile = '~/Desktop/todo.taskpaper'
searchtag = '@today'


command: "cat #{todolistfile} | grep #{searchtag} | grep -v @done | grep -v Archive: | sed s/@today//g |
awk 'BEGIN {print \"<ol>\"}
    {for (i=1; i<=NF; i++) {
      if (i == 1) {
          print \"<li>\"
        }
      else if ($i ~ /@.*/ ) {
          print \"<div class='tag'>\" $i \"</div>\"
        }
      else {
        print $i
        }
      }
        print \"</li>\"
      }
      END {print \"</ol>\"}'
"



# refresh
refreshFrequency: 36000

style: """
  top: 10%
  left: 22%
  color: #FFF
  font-family: Helvetica Neue

  h
    display: block
    text-align: left
    font-size: 24px
    font-weight: bold

  div
    display: block
    text-shadow: 0 0 1px rgba(#000, 0.5)
    font-size: 14px
    font-weight: normal

  ol
    padding-left: 20px

  .tag
    display:inline
    color: #778899
    font-weight: bold

  .searchtag
    color: #808
    font-weight: bold
  """

# You might want to adjust the title as well.
render: -> """
  <h>The Big 3 </h>
  <div class='taskpaper'></div>
"""

update: (output, domEl) ->
  $(domEl).find('.taskpaper').html(output)
