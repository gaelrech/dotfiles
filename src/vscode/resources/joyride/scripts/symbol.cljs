(ns symbol
  (:require ["ext://betterthantomorrow.calva$v1" :as calva]
            ["vscode" :as vscode]
            [promesa.core :as p]
            [util.editor :as editor]))

(p/let [editor ^js vscode/window.activeTextEditor
        selection (editor/current-selection)
        text (.getText (.-document editor) selection)
        _ (when (not= text "") (vscode/commands.executeCommand "editor.action.clipboardCopyAction"))
        _ (vscode/commands.executeCommand "workbench.action.showAllSymbols")
        _ (when (not= text "") (vscode/commands.executeCommand "editor.action.clipboardPasteAction"))]
  (aset editor "selection" selection))
