/*
 * Copyright (C) 2021 by Oleksandr Zolotov <alex@nextcloud.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
 * for more details.
 */

import QtQml 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import Style 1.0

import com.nextcloud.desktopclient 1.0

TextField {
    id: trayWindowUnifiedSearchTextField

    property bool isSearchInProgress: false

    readonly property color textFieldIconsColor: Style.menuBorder

    readonly property int textFieldIconsOffset: Style.trayHorizontalMargin

    readonly property double textFieldIconsScaleFactor: 0.6

    readonly property int textFieldHorizontalPaddingOffset: Style.trayHorizontalMargin

    signal clearText()

    leftPadding: trayWindowUnifiedSearchTextFieldSearchIcon.width + trayWindowUnifiedSearchTextFieldSearchIcon.anchors.leftMargin + textFieldHorizontalPaddingOffset - 1
    rightPadding: trayWindowUnifiedSearchTextFieldClearTextButton.width + trayWindowUnifiedSearchTextFieldClearTextButton.anchors.rightMargin + textFieldHorizontalPaddingOffset

    placeholderText: qsTr("Search files, messages, events …")

    selectByMouse: true

    palette.text: Style.ncSecondaryTextColor

    background: Rectangle {
        radius: 5
        border.color: parent.activeFocus ? UserModel.currentUser.accentColor : Style.menuBorder
        border.width: 1
        color: Style.backgroundColor
    }

    Image {
        id: trayWindowUnifiedSearchTextFieldSearchIcon
        width: Style.trayListItemIconSize - anchors.leftMargin
        fillMode: Image.PreserveAspectFit
        horizontalAlignment: Image.AlignLeft

        anchors {
            left: parent.left
            leftMargin: parent.textFieldIconsOffset
            verticalCenter: parent.verticalCenter
        }

        visible: !trayWindowUnifiedSearchTextField.isSearchInProgress

        smooth: true;
        antialiasing: true
        mipmap: true
        source: "image://svgimage-custom-color/search.svg" + "/" + trayWindowUnifiedSearchTextField.textFieldIconsColor
        sourceSize: Qt.size(parent.height * parent.textFieldIconsScaleFactor, parent.height * parent.textFieldIconsScaleFactor)
    }

    NCBusyIndicator {
        id: busyIndicator

        anchors {
            left: trayWindowUnifiedSearchTextField.left
            bottom: trayWindowUnifiedSearchTextField.bottom
            leftMargin: trayWindowUnifiedSearchTextField.textFieldIconsOffset - 4
            topMargin: 4
            bottomMargin: 4
            verticalCenter: trayWindowUnifiedSearchTextField.verticalCenter
        }

        width: height
        color: trayWindowUnifiedSearchTextField.textFieldIconsColor
        visible: trayWindowUnifiedSearchTextField.isSearchInProgress
        running: visible
    }

    Image {
        id: trayWindowUnifiedSearchTextFieldClearTextButton

        anchors {
            right: parent.right
            rightMargin: parent.textFieldIconsOffset
            verticalCenter: parent.verticalCenter
        }

        smooth: true;
        antialiasing: true
        mipmap: true

        visible: parent.text
        source: "image://svgimage-custom-color/clear.svg" + "/" + trayWindowUnifiedSearchTextField.textFieldIconsColor
        sourceSize: Qt.size(parent.height * parent.textFieldIconsScaleFactor, parent.height * parent.textFieldIconsScaleFactor)

        MouseArea {
            id: trayWindowUnifiedSearchTextFieldClearTextButtonMouseArea

            anchors.fill: parent

            onClicked: trayWindowUnifiedSearchTextField.clearText()
        }
    }
}
