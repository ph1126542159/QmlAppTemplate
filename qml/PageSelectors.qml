import QtQuick
import QtQuick.Controls

import ThemeEngine 1.0

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: isDesktop; }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20

        topPadding: 16
        bottomPadding: 16
        spacing: 20

        SectionTitle { /////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 12
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 12

            text: qsTr("Selectors")
            source: ""
        }

        SelectorMenuThemed {
            height: 40

            currentSelection: 1
            model: ListModel {
                id: lmSelectorMenuImg1
                ListElement { idx: 1; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 20; }
                ListElement { idx: 2; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 26; }
                ListElement { idx: 3; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 32; }
            }

            onMenuSelected: (index) => {
                //console.log("SelectorMenu clicked #" + index)
                currentSelection = index
            }
        }

        SelectorMenuThemed {
            height: 32

            currentSelection: 1
            model: ListModel {
                id: lmSelectorMenuTxt1
                ListElement { idx: 1; txt: "4/3"; src: ""; sz: 0; }
                ListElement { idx: 2; txt: "16/9"; src: ""; sz: 0; }
                ListElement { idx: 3; txt: "21/9"; src: ""; sz: 0; }
            }

            onMenuSelected: (index) => {
                //console.log("SelectorMenu clicked #" + index)
                currentSelection = index
            }
        }

        SelectorMenu {
            height: 40

            currentSelection: 1
            model: ListModel {
                id: lmSelectorMenuImg2
                ListElement { idx: 1; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 20; }
                ListElement { idx: 2; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 26; }
                ListElement { idx: 3; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 32; }
            }

            onMenuSelected: (index) => {
                //console.log("SelectorMenu clicked #" + index)
                currentSelection = index
            }
        }

        SelectorMenu {
            height: 32

            model: ListModel {
                id: lmSelectorMenuTxt2
                ListElement { idx: 1; txt: "4/3"; src: ""; sz: 0; }
                ListElement { idx: 2; txt: "16/9"; src: ""; sz: 0; }
                ListElement { idx: 3; txt: "21/9"; src: ""; sz: 0; }
            }

            onMenuSelected: (index) => {
                //console.log("SelectorMenu clicked #" + index)
                currentSelection = index
            }
        }
    }
}
