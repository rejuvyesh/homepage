---
title: About
description: About Jayesh Kumar Gupta and the site.
---

About
=========

<div style="background:#F88379;text-align:center;">Work Under Progress</div>
<div class="soft">
<span class="align_left"> Last Modified: 10 February, 2013 </span><span class="align_right"> Status: _in progress_ </span>
</div>
Me
---
Hi! I am Jayesh Kumar Gupta. I am a sophomore undergraduate at IIT Kanpur.

So how should I go about describing myself?

Judging by time within which I redesigned my website, I guess I am fairly narcissistic. 

I love making lists. I see lists as a means to build against the forces of information multitude. TODO

I like books. I don't have any particular affinity to printed books having read most books in electronic format since a long time.[^0]

I am really sheepish to accept this but I really don't play any video games. I have seldom found them more interesting or even fun, than say a book or browsing the internet.[^3]


Blog
----

> Just as inviting people over forces you to clean up your apartment, writing something that other people will read forces you to think well. [^1]

I have been trying to start a blog sort of thing for quite some time.[^2]

Why, you may ask? All articles I have read about improving your writing skill reach a common conclusion: "only way to improve your writing skills is to write". A lot, I guess. I read plenty of books, papers, blogs and magazine articles. I think blogging as a much better way to share what I have been reading and thinking about. Developing critical thinking requires a lot of practice, and writing is a useful aid in reflection. Writing about stuff forces me to think harder, helping me to sharpen my thoughts, and improve my writing in the process too. Moreover I am into tracking my beliefs and ideas, and how they change with time.

Then why not facebook ^[Or Google+]? If you look at the history of internet, you'll realize that "big sites rise and fall in popularity"^[If you don't believe me just think of [Yahoo!](http://yahoo.com) or Orkut] while I think I'll want my internet identity to persist longer than those sites do. I don't want to be reduced to be a handle tacked at the end of a huge company's website ^[Facebook, I am looking at you]. Moreover, I find it very hard to find older posts on facebook ^[Especially without Google Searches possible.]. With increasing tension between the social stalwarts like Facebook vs Twitter (over the Instagram issue) or Facebook vs Google+, instead of collaborating to make the web a better place, it has become pertinent to me that I shouldn't leave my data to whims of a particular company.  

 




[^0]: I haven't really owned many books and my school library was nearly close to useless, once I had some sort of access to the internet.
[^1]: [_Paul Graham_](http://www.paulgraham.com/essay.html)
[^2]: As some might know/remember, _Rejuvyesh Spricht_.
[^3]: This might be more because I am pretty bad at them. (Actually I am pretty bad at anything which requires quick decisions.) Only computer game I liked was [Simcity 4](http://en.wikipedia.org/wiki/SimCity_4).


This Site
---------

I chose Hakyll as my static site generator, as it's quite similar, in terms of configuration, to [Xmonad](http://xmonad.org), my window manger. I shifted my blog too here from [Wordpress](http://wordpress.com) mainly for bringing my writing under [version control](), and the markdown support. I cringed every time I had to use their crappy web-GUI and I really had no use for their _special_ features.

The only issue I have with Archlinux, is the dependency hell of Haskell libraries. Only sane way to circumnavigate this issue is by using `hsenv`. `hsenv` is pretty neat in allowing a sandboxed environment for Haskell development. The biggest dependency of-course is `pandoc`. But seriously you must already have it installed[^a]. Then follow the advice on Hakyll's homepage.

I write source files in [Pandoc](http://johnmacfarlane.net/pandoc/) Markdown. Comments are outsourced to [Disqus](http://disqus.com/). This helps me keeping my site towards the minimal side [^b].

To use Hakyll, you `cd` into your repository and `runhaskell site.hs build` (with `site.hs` having whatever options you like). Hakyll will build a static HTML/CSS hierarchy inside`_site/`; you can then do something like `runhaskell site.hs preview` and direct your browser to `http://0.0.0.0:8000` to view the content.

I'll try to keep everything on this site self-contained [^c] and hope to keep it accessible forever[^d]. Good thing about `Hakyll` is that it comes with a link checker, so I guess dead links would be a non-issue.

[^a]: If not then do a `cabal install` after creating a `hsenv` environment.

[^b]: Without  without sacrificing usability to the altar of minimalism,  I hope.

[^c]: Except the external links of-course. IIT-K does not provide me more than 50-MB of space to host any other content, so I might need to relocate images.

[^d]: I have enough content, I might get my own domain name, and think of hosting it somewhere. But be assured that the entire repository will remain available on [Github](http://github.com) (or somewhere else).

Signing Off!
