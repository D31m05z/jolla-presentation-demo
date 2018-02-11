import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow
{
    initialPage: Page {
     id: page
     SilicaListView {
         PullDownMenu {
             MenuItem {
                 text: "Clear all"
                 onClicked: todoModel.clear()
             }
         }

         header: Column {
             spacing: Theme.paddingMedium
             PageHeader {
                 title: "Todo"
             }
             TextField {
                 placeholderText: "Add an entry"
                 width: page.width
                 EnterKey.onClicked: {
                     if(text !=""){
                         todoModel.append({"description": text})
                         text = ""
                     }
                     focus = false
                 }
             }
         }

         anchors.fill: page
         model: todoModel
         delegate: ListItem {
             menu: contextMenu
            Label {
                anchors.centerIn:  parent
                text : description
            }

            function remove(){
                remorseAction("Deleting", function() {todoModel.remove(index)})
            }

            Component {
                id: contextMenu
                ContextMenu {
                    MenuItem {
                        text: "Remove"
                        onClicked:  remove()
                    }
                }
            }
         }
     }

     ListModel{
         id: todoModel
         ListElement{
             description: "Buy Beer"
         }
     }

    }
    //undefined
    cover: CoverBackground {
        Label {
            anchors.centerIn: parent
            text: todoModel.count >0 ? todoModel.get(0).description : "Nothing to do"
        }
    }
    CoverActionList {
        CoverAction{
            iconSource:"image://theme/icon-cover-cancel"
            onTriggered: if(todoModel.count>0) todoModel.remove(0)
        }
    }
}


