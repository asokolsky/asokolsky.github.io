class Button:
    '''
    From https://stackabuse.com/python-specific-design-patterns/

    The Prebound Method Pattern focuses on binding methods to specific data or
    context well in advance of the method's execution. The method, once bound,
    doesn't need explicit context passed in during invocation; instead, it
    operates on the prebound data, ensuring a seamless and elegant interaction.
    '''

    def __init__(self, label):
        self.label = label
        # Prebinding the display_label method to the current instance
        self.click_action = lambda: self.display_label(self)

    def display_label(self, bound_button):
        print(f"Button pressed: {bound_button.label}")

    def click(self):
        self.click_action()

# buttonA = Button("Submit")
# buttonB = Button("Cancel")

# buttonA.click()
# buttonB.click()

# As expected, clicking each button produced the appropriate output:

# Button pressed: Submit
# Button pressed: Cancel
