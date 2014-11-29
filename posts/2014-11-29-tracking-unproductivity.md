---
title: Tracking (Un)Productivity
description: Analysis of nearly an year of recorded laptop usage
author: rejuvyesh
status: finished
lastmodified: 29 November, 2014
belief: highly likely
tags: quantified self, visualization, hack
---

Another semester is over. And since I am not working on any research project, I am practically free[^lying]. This is turning into another bad semester in terms of grades. Also the year is coming to an end. Now is the time to reflect and find out what went wrong. Sitting around and thinking how the year went is not really a rational method to find the right answers. We need empirical data. But hey, I have been tracking my laptop usage since the start of the year (18th Jan.), with the help of [arbtt](http://arbtt.nomeata.de/). So may be that is enough data to find out how exactly I spend my day and answer questions like do I really spend as much time productively as I think?

So I trawled the web what other people have been doing and found [ulogme](http://cs.stanford.edu/people/karpathy/ulogme/). Looking at it, I realized, this is it. This is what I want. But unfortunately I hadn't been using [ulogme](http://cs.stanford.edu/people/karpathy/ulogme/), since the start of this year. Also when I looked into the source code, I realized that its `json` files contain the entire usage history. I guess it it okay if you are going to be the only one looking at the results. My plan was to share everything with the world. Shame may help change my habits[^shame]. So I ended up writing some spaghetti [code](https://github.com/rejuvyesh/dailystats/blob/master/readdailystats.py) to convert `arbtt-stats` output into `json` files which can be loaded by any web application. I toyed with the idea of writing a full-blown app in [react.js](http://facebook.github.io/react/). But I had to remind myself that

1. I don't know much javascript and it would be a lot to learn
2. I don't really like javascript as a language anyway. So I ended up writing a bastardized front-end in plain html and [d3.js](http://d3js.org/), plus some javascript, stealing quite a few things from ulogme. In the spirit of data sharing here I present the process and the results.

# Single Day View

We first get the data for every day and every minute using arbtt:

```sh
# Daily
$ arbtt-stats --categorizefile=./categorize.cfg \
              --for-each=day --output-format=CSV > /tmp/cleanstats.csv
# Minute by minute
$ arbtt-stats --categorizefile=./minute-cat.cfg \
              --for-each=minute --output-format=CSV > /tmp/minutestats.csv
```

We parse these files in python, using `readdailystats.py` and create `json` files containing daily usage statistics as percentage of total time. We also store the minutes of the day when I was doing one of the things listed in the tags. See [an example](http://rejuvyesh.com/dailystats/data/daily-2014-11-29.json).

Now we come to the most important part: visualization.

Like `ulogme` we can go back and forth and see usage for different days using the header. I still haven't implemented the blogging feature since I am not sure of its usage. I can already use [jrnl](http://maebert.github.io/jrnl/) for that.

![Header - day information ](/images/daily-stats-header.png ) 

We first show the breakdown of all tags that I was occupied with on that day. Here is one from 29th November.

![Breakdown of Active Windows](/images/pie-chart-29-Nov.png ) 

Yeah, still a lot of time wasted on social sites. Even though close the window in a few minutes, they add up to a lot.

We also generate barcode plots for the entire duration of day seeking when a particular activity was being done. For example this is breakdown of the day on 29th Nov.

![Barcode visualization of the day](/images/barcode-Nov29.png ) 

# Yearly Overview

We need to get the context to really understand the implications and avoid jumping to conclusions. Clicking on 'Overview' link on the above header does the obvious and shows us an overview stacked bar chart.

![](/images/tags-year-review.png ) 

![Total time spent per day in various applications over a period of ~11 months. The tags can be clicked to toggle visualization of any tag](/images/year-review.svg )

See the full-size image [here](/images/year-review.png). Yeah the image looks pretty cool. But it is pretty depressing to see so much time consumed on social networking sites. Let's remove all unproductive tags and see the real picture.

![](/images/yearly-productive-tags.png ) 

![Total time spent on productive activities as seen by the header over a period of same ~11 months.](/images/yearly-productive-overview.svg )

So depressing. See [larger](/images/yearly-productive-overview.png). Few comments:

- May-July, very little productive work because I was working on an assigned computer which was not my laptop.
- Most productive day on Fri, 18th April - a little over 8 hours. Otherwise it is extremely depressing that I hardly seem to get 4 hours of productive work -- not even that if I remove reading and writing mails.
- You can see me reading a lot of pdfs when I have my exams. Not much otherwise.
- Reading mails take a long time. Hmm. Possible I guess. Writing mails to professors, replying to MTBA help requests, they probably did.


# Conclusion

I need to clean up and generalize the code. Right now it seems, it is just geared towards solving my problem. Any suggestions on how to go about doing that are most welcome. I still need toa collect more data like sleep etc., so that we can find correlations and hopefully some causations.

I also plan to do serious statistical analysis on the data. But first I need to study it properly. Finding mean, median may give some insight but I need to do more. See [Gwern](http://www.gwern.net/Google%20shutdowns) for example.

Of course, pull requests are among the nicest things you can do <span data-icon="&#xe004;" aria-hidden="true" style="color:#005580"></span>!


[^lying]: I am lying here. I have to fill my grad applications and write my SoP. Everytime I sit down to write my SoP, I get distracted by something or the other. Basically I find writing my SoP pretty stressful and am doing anything to avoid it. But well, I should start now.

[^shame]: Yeah, I was somewhat aware of the results. I can read the `arbtt-stats` output, you know?





