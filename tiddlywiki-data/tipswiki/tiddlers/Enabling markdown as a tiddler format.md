* For a wiki being run on node.js, this requires that
  * the server be stopped (i think?)
  * the `tiddlywiki.info` file sitting in the top of the wiki directory be edited.

The `.info` file is just JSON. Because markdown is a built-in plugin, it just need to be enabled by adding it to the "plugins" list:

```json
    "plugins": [
        "tiddlywiki/tiddlyweb",
        "tiddlywiki/filesystem",
        "tiddlywiki/highlight",
        "tiddlywiki/markdown" // <-- here
    ],
```

## Auto-linkifying

By default, the markdown parser doesn't automatically turn things that look like links, into links - you need to put them in angle brackets (`<` ... `>`).

To enable auto-linkifying:

* go to tools/ advanced search, paste in `$:/config/markdown/linkify`
* go to the "shadow" tab, and open the tiddler and edit it
* change the contents, "false", to "true".

You may then need to refresh.


## Allowing wiki links

By default, links to tiddlers [don't work in markdown][no-md-tiddlylinks] – i.e. you can't go `[[title of some tiddler]]` and get it to link. (See also [this bug report](https://github.com/Jermolene/TiddlyWiki5/issues/6045).)

[no-md-tiddlylinks]: https://talk.tiddlywiki.org/t/markdown-plugin-rendering-wikitext-links/772/8

The fix:

* go to tools / advanced search.

  paste in: `$:/config/markdown/renderWikiTextPragma`

* Go to "Shadows", open the tiddler.

  Should contain the following content:

  `\rules only html image macrocallinline syslink transcludeinline wikilink filteredtranscludeblock macrocallblock transcludeblock \define \end`

* change that to:

  `\rules only html image macrocallinline syslink transcludeinline wikilink` <span>&nbsp;</span> **`prettylink`** <span>&nbsp;</span> `filteredtranscludeblock macrocallblock transcludeblock \define \end`

* may then need to re-load



