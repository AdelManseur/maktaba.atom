Maktaba = require '../lib/maktaba'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Maktaba", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('maktaba')

  describe "when the maktaba:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.maktaba')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'maktaba:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.maktaba')).toExist()

        maktabaElement = workspaceElement.querySelector('.maktaba')
        expect(maktabaElement).toExist()

        maktabaPanel = atom.workspace.panelForItem(maktabaElement)
        expect(maktabaPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'maktaba:toggle'
        expect(maktabaPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.maktaba')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'maktaba:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        maktabaElement = workspaceElement.querySelector('.maktaba')
        expect(maktabaElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'maktaba:toggle'
        expect(maktabaElement).not.toBeVisible()
