This is a blogging eco-system written using flutter-web.
I wanted to customize few things in the existing blogging services which weren't possible without subscribing for an expensive tier and so decided to write my own blogging sytem.
It is entirely written in flutter web and hosted on heroku at http://www.wipentrepreneur.com/ - check it out and let me know things that can be modified or made better.
I still have a few issues I am trying to solve and it would be awesome to have someone help me with that. The major features I wanna have are :
1. Social media sharing options for facebook, linkedIn and pinterest. (Currently flutter web doesn't have a ready plugin - there is one for android and iOS but not for web and so it needs to be coded from stratch - thats why I decided to keep it for later.)
2. Need to add a whole comments module - but only allow logged-in users to comment so the entire login/comment module needs to be put in place. There are part of the comments UI already coded which you will find commented out in the code but its not complete.
3. There is a bug with links - I am using the library - https://pub.dev/packages/markdown_widget for my posts but whenever I put in a link it take a line space - but I want the link to be part of the same line (should not enter any space) - this needs to be fixed.

Any PRs related to these 3 points or in general to make my blog better are most welcome!

