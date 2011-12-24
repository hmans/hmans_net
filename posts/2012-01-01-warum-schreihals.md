---
title: Warum ich Schreihals gebaut habe.
status: draft
tags: [schreihals]
summary: Es gibt nun wirklich genug Blogging-Tools "für Hacker". Wieso also noch eines bauen? Nun, erstens programmiere ich gern. Weil es Spaß macht. Und man dabei _immer_ etwas Neues lernt.
---


Zweitens hat mich bisher keines der anderen Tools so richtig überzeugen können. Wenn ich eine Liste von Dingen schreiben müsste, die ich vom Weblog-Tool meiner Träume erwarten würde, dann würde die ungefähr so aussehen:

* Schreiben von Blogbeiträgen mit Markdown und nichts als Markdown.
* Für Entwickler ausgelegt. Syntaxhighlighting!
* Keine überflüssigen Features, sauberes Code-Design
* Keine Generierung statischer HTML-Files (brauche ich nicht.)
* Portabler Code. Sprich: läuft auf Heroku. Aber auch überall sonst.
* Wenn schon ein Gem, dann sollte bitte möglichst viel Code auch im Gem sein. Mein Blog-Codeprojekt sollte möglichst nur aus Markdown-Files bestehen. Und Katzenfotos.
* Entwickelt und anpassbar mit HAML und SASS. Out of the box.

Nachdem ich wiederholt feststellen musste, dass so ziemlich alle Blogging-Tools da draußen entweder bei einem dieser Punkte versagen oder gleich komplett kaputt sind, musste ich mein eigenes schreiben. Das könnt ihr sicher verstehen. Ich muss mich für nichts entschuldigen. _Don't you judge me!_

Schreihals kann all die Dinge da oben. Und sonst nicht viel. Wahrscheinlich kann man damit nicht _alles_ machen. Aber für's (technische) Bloggen sollte es reichen.

### Wie funktioniert der Spaß?

Ich möchte man kurz beschreiben, wie man (gemessen am aktuellen Stand des Codes) ein Schreihals-Blog aufsetzt. Später werde ich vielleicht ein Executable zur Verfügung stellen, mit dem man ein Skelett für ein neues Blog generieren kann. Aber ihr werdet sehen, dass das fast nicht nötig ist.

1. Zuerst brauchen wir ein `config.ru`-File, damit Rack weiß, was läuft:

        :::ruby
        require 'schreihals'

        class MyBlog < Schreihals::App
          set :blog_title, "Hendrik Mans"
          set :blog_description, "Hendrik Mans lebt in Hamburg und baut Sachen im Internet."
          set :author_name, "Hendrik Mans"
          set :disqus_name, "hmans"
        end

        run MyBlog

    Eigentlich selbsterklärend.

2. Jetzt legen wir im selben Verzeichnis ein `posts/`-Verzeichnis an. Dort kommen die Beiträge rein. Idealerweise Markdown mit YAML-Front-Matter. Das sieht zum Beispiel so aus:

        :::yaml
        ---
        title: Hey, was geht?
        date: 2011-12-24
        slug: was-geht
        ---

        Was geht, Leute? Ich bin ein Schreihals-Blog-Artikel, fuck yeah!

    Die Attribute `slug` und `date` sind dabei optional; wenn sie fehlen, werden sie aus dem Namen der Datei gezogen. In diesem Beispiel könnte die Datei also `2011-12-24-was-geht.md` heißen, und sowohl Datum als auch URL-Slug würden automatisch erstellt werden.

3. Das war's! Jetzt müssen wir das Ding nur noch starten (z.B. per `rackup`, `shotgun` etc.) oder deployen (läuft out of the box auf einem kostenlosen Heroku-Account).

### Ein paar Tips & Tricks

* Posts ohne Datum (`date`-Attribut) sind ganz normale Seiten. Wie zum Beispiel [das Impressum](/impressum) dieses Blogs.
* Posts können als `status: draft` markiert werden. Sie sind dann zwar immer noch über ihre URL aufrufbar, werden aber nicht automatisch auf der Startseite angezeigt.
* Natürlich unterstützt Schreihals [Disqus-Kommentare](http://disqus.com/dashboard/). (Kann man global und für einzelne Posts und Seiten an- bzw. abschalten) und [Google Analytics](https://www.google.com/analytics/).
