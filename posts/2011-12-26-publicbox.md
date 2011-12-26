---
title: publicbox
summary: Großartige Dinge werden geschehen, aber erst einmal musste ich einen Webservice schreiben, der das Inhaltsverzeichnis von öffentlichen Dropbox-Ordnern als JSON ausspuckt.
link:

# More options:
#
# status: draft
# read_more:
# disqus: false
---

Schreihals soll ein cooles Ding werden, also habe ich mir überlegt, dass man es doch auch an [Dropbox](http://www.dropbox.com) anflanschen könnte. Anstatt neue Beiträge dann per git zu deployen, soll der User die Markdown-Files einfach ein Dropbox-Verzeichnis legen, und sie erscheinen automatisch auf seinem Blog. _ZOMG MAGIC._

Dropbox hat eine sehr umfangreiche API, die sich aber leider nicht zu diesem Zweck eignet, denn sie verlangt Authorisierung über OAuth. Das ist alles schön und gut, wenn man einen _Dienst_ baut, der irgendwo läuft und auf die Dropboxen seiner Nutzer zugreifen soll. Aber Schreihals ist ein Open-Source-Tool, das sich der User bittsehr auf seinem eigenen Server (oder Heroku) installieren soll. Was wollen wir da mit OAuth? Ich werde wohl kaum einen jeden Schreihals-User darum bitten müssen, erst einmal sein neues Blog als Dropbox-API-App anzulegen. Pfui!

Dropbox bietet zum Glück die Möglichkeit an, auf Ordner per Share-URL zuzugreifen, allerdings ohne einfache Möglichkeit, deren Inhalt programmatisch auszulesen, denn der Index, das Inhaltsverzeichnis, wird lediglich als schön durchdesignte (naja) HTML-Seite ausgeliefert, und nicht, wie ursprünglich von mir erhofft, auch als JSON oder XML.

Also habe ich mich eben nach der Rückkehr von den Schwiegereltern an meinen alten iMac gesetzt, Sinatra und nokogiri ausgepackt, und [PublicBox](http://publicbox.heroku.com/) gebaut. Das Ding funktioniert ganz einfach: URL zu einem ge-shared-ten Dropbox-Folder rein, JSON raus. Toll! Genauere Informationen dort.

Werde nun als nächstes den Schreihals erweitern, dass er sich über diesen Weg die Posts aus Dropbox ziehen kann, _und dann ist alles gut_. Puh.
