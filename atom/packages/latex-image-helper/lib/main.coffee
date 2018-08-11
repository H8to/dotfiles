
{CompositeDisposable,File,Directory} = require 'atom'

module.exports = LatexImgHelper =

	activate: (state) ->
		atom.commands.onWillDispatch (e)  =>
			if e.type is "core:paste"
				editor = atom.workspace.getActiveTextEditor()
				return unless editor
				grammar = editor.getGrammar()
				console.log(grammar.scopeName)
				return unless grammar
				return unless grammar.scopeName is 'text.tex.latex'
				console.log('Language detected')

				clipboard = require 'clipboard'
				img = clipboard.readImage()

				return if img.isEmpty()

				e.stopImmediatePropagation()

				imgbuffer = img.toPNG()

				thefile = new File(editor.getPath())
				assetsDirPath = thefile.getParent().getPath() + "/images"

				crypto = require "crypto"
				md5 = crypto.createHash 'md5'
				md5.update(imgbuffer)

				filename = "#{thefile.getBaseName().replace(/\.\w+$/, '').replace(/\s+/g,'')}-#{md5.digest('hex').slice(0,5)}.png"

				@createDirectory assetsDirPath, ()=>
					@writePng assetsDirPath+'/', filename, imgbuffer, ()=>
						@insertUrl "\\begin{figure}[H]\\centering\\includegraphics[width=1.0\\textwidth]\{./images/#{filename}\}\\caption\{\}\\end\{figure\}\\\\",editor

				return false

	createDirectory: (dirPath, callback)->
		assetsDir = new Directory(dirPath)

		assetsDir.exists().then (existed) =>
			if not existed
				assetsDir.create().then (created) =>
					if created
						console.log 'Success Create dir'
						callback()
			else
				callback()

	writePng: (assetsDir, filename, buffer, callback)->
		fs = require('fs')
		fs.writeFile assetsDir+filename, buffer, 'binary',() =>
			console.log('Finish clip image')
			callback()

	insertUrl: (url,editor) ->
		editor.insertText(url)


	deactivate: ->


	serialize: ->
