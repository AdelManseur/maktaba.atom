MaktabaView = require './maktaba-view'
{CompositeDisposable} = require 'atom'

module.exports = Maktaba =
  maktabaView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @maktabaView = new MaktabaView(state.maktabaViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @maktabaView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'maktaba:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @maktabaView.destroy()

  serialize: ->
    maktabaViewState: @maktabaView.serialize()

  toggle: ->
    console.log 'Maktaba was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
