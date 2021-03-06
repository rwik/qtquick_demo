/** This file is part of QtQuickIVIDemo**

Copyright  2010 Nokia Corporation and/or its subsidiary(-ies).*
All rights reserved.

Contact:  Nokia Corporation qt-info@nokia.com

You may use this file under the terms of the BSD license as follows:

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
* Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
  the names of its contributors may be used to endorse or promote
  products derived from this software without specific prior written
  permission.


THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
*/
import Qt 4.7

// ToolbarButton is a state aware button
// (on/off states) used in Toolbar, and
// the button can blink. Button
// can be also disabled, in which case
// it is not visible.
Item {
    id: wrapper

    // Current selection state (on/off)
    property bool selected: false

    width: 50
    height:  50
    // Hidden when disabled, when not
    // active, opacity is 50%
    opacity: buttonEnabled ? 0.5 : 0

    // Button icon
    Image {
        id: icon

        anchors.centerIn: parent
        source: iconImage

        // Blinking animation, which
        // is done if 'blink' property is true
        SequentialAnimation {
            loops: Animation.Infinite
            running: blink

            PropertyAnimation {
                target: icon
                property: "opacity"
                from: 1.0; to: 0.0
                duration: 1000
            }
            PropertyAnimation {
                target: icon
                property: "opacity"
                from: 0.0; to: 1.0
                duration: 1000
            }
        }
    }

    // Button text below the icon
    Text {
        id: button

        anchors.horizontalCenter: icon.horizontalCenter
        // If the button shares text with an adjacent button
        // place the text 50% outside the icon
        anchors.horizontalCenterOffset:
            (shareButtonText != undefined && shareButtonText)
            ? (wrapper.width + buttons.spacing)/2 : 0
        anchors.top: icon.bottom
        anchors.topMargin: 5
        text: buttonText
        font.pixelSize: 12
        font.bold: true
        color: "white"
    }

    // Selected state displays the icon
    // and button highlighted
    states:
        State {
            name: "selected"
            when: selected

            PropertyChanges {
                target: wrapper
                opacity: 1

            }
        }

    transitions:
        Transition {
            to: "selected"
            reversible: true

            NumberAnimation { properties: "opacity"; duration: 500 }
        }
}
