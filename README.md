# rkmtlab.github.io/openhouse2016
## Getting started

1. Clone this repository: `git clone git@github.com:rkmtlab/openhouse2016.git`
2. Install Sass via rubygems: `bundle install`
3. Compile stylesheets: `sass -r sass-globbing assets/styles/style.scss build`
4. Run web server: `ruby -run -e httpd . -p 8000`
5. Open with your web browser: [localhost:8000](http://localhost:8000)


Compiled stylesheets are generetad ./ directory.
So you should do something like below.

a. `mkdir tmp`
b. `mv build tmp`
3. `sass -r sass-globbing assets/styles/style.scss build`
c. `mv build tmp/style.css; mv build.map tmp/style.css.map; mv tmp build`
4. `ruby -run -e httpd . -p 8000`


