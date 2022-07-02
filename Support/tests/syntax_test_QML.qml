// SYNTAX TEST "Packages/Sublime-QML/Support/QML.sublime-syntax"

pragma Singleton
// <-  meta.pragma keyword.control.pragma
// ^^^ meta.pragma keyword.control.pragma
//     ^^^^^^^^^ meta.pragma storage.modifier.singleton

/* no version */
import QtQml
// <- source.qml meta.import keyword.control.import
//     ^^^^^ meta.path meta.generic-name

/* major-only version */
import QtQuick 2
// <-               meta.import.qml
// ^^^^^^^^^^^^^    meta.import.qml
//              ^ - meta.import.qml
//             ^ meta.import constant.numeric

import QtQuick 2 . 15
//             ^^^^^^ meta.import meta.number.version
//               ^ punctuation.separator.decimal

/* major & minor version */
import QtQuick.Layouts 2.15
// <-                          meta.import.qml
// ^^^^^^^^^^^^^^^^^^^^^^^^    meta.import.qml
//                         ^ - meta.import.qml
// <- meta.import keyword.control.import
//     ^^^^^^^^^^^^^^^ meta.path
//            ^ punctuation.accessor
//                     ^^^^ meta.number.version
//                     ^ constant.numeric
//                      ^ punctuation.separator
//                       ^^ constant.numeric

import org.kde . kirigami 2.20 as Kirigami
// <-                                       meta.import.qml
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    meta.import.qml
//                                        ^ - meta.import.qml
//                        ^^^^ meta.number.version
//                             ^^ keyword.operator.as
//                                ^^^^^^^^ meta.import.alias entity.name.namespace

import QtQuick.Controls as Controls
// <-                                  meta.import.qml
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    meta.import.qml
//                                 ^ - meta.import.qml
//     ^^^^^^^^^^^^^^^^ meta.path
//     ^^^^^^^ meta.generic-name
//            ^ punctuation.accessor
//             ^^^^^^^^ meta.generic-name
//                      ^^ keyword.operator.as
//                         ^^^^^^^^ meta.import.alias entity.name.namespace

import QtQuick.Controls @QQC2_VERSION@ as Controls;
// <-                                               meta.import.qml
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.import.qml
//                                                 ^ - meta.import.qml
//     ^^^^^^^^^^^^^^^^ meta.path
//     ^^^^^^^ meta.generic-name
//            ^ punctuation.accessor
//             ^^^^^^^^ meta.generic-name
//                      ^^^^^^^^^^^^^^ variable.other.cmake
//                      ^              punctuation.definition.variable.begin.cmake
//                                   ^ punctuation.definition.variable.end.cmake
//                                     ^^ meta.import keyword.operator.as
//                                                ^ punctuation.terminator.statement

import Abc as abc
//            ^^^ meta.import.alias invalid.illegal.name.import

import ":/components"
//     ^^^^^^^^^^^^^^ meta.string string.quoted.double

import ':/components' 2.5 as Components
// <-                                   meta.import.qml
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.import.qml
//                                     ^ - meta.import.qml
//     ^^^^^^^^^^^^^^ meta.string string.quoted.single
//                    ^^^ meta.number.version

// Make sure import aliases work with strings
import "./logic.js" as Logic
//                  ^^ meta.import meta.import.alias keyword.operator.as

import `templates`
//     ^^^^^^^^^^^ meta.import.qml invalid.illegal.import-string meta.string string.quoted.other

import One; import Two;
//        ^             punctuation.terminator.statement.qml - punctuation.terminator.statement.empty
//                    ^ punctuation.terminator.statement.qml - punctuation.terminator.statement.empty


QtObject {}
// <- support.class
// ^^^^^ support.class

Kirigami.TextField {/**/}
// ^^^^^ support.class
//      ^ punctuation.accessor
//       ^^^^^^^^^ support.class
//                 ^^^^^^ meta.block.qml
//                 ^ punctuation.section.block.begin
//                  ^^^^ comment.block
//                      ^ punctuation.section.block.end

Nested {
// ^^^ support.class
//     ^ meta.block
    Inner {}
//  ^^^^^ meta.block support.class
//        ^^ meta.block meta.block
    Foo.Bar {}
//  ^^^ meta.block support.class
//      ^^^ meta.block support.class
//          ^^ meta.block meta.block
}
// <- meta.block punctuation.section.block.end

// <- - meta.block

)
// <- invalid.illegal.stray-bracket-end
}
// <- invalid.illegal.stray-bracket-end
]
// <- invalid.illegal.stray-bracket-end

QtObject {
    )
    // <- invalid.illegal.stray-bracket-end
    ]
    // <- invalid.illegal.stray-bracket-end
}

one.two {}
// <-   - support.class
//  ^^^ - support.class
one.two.three {}
//  ^^^ - support.class

WithId {
    id: one two
//  ^^^^^^^ meta.binding.property.qml
//    ^ keyword.operator.assignment
//      ^^^ entity.name.label
//          ^^^ invalid.illegal
    id : three
//     ^ meta.binding.property.qml keyword.operator.assignment
//       ^^^^^ entity.name.label
    id: Four
//      ^^^^ invalid.illegal.identifier
    id: 5
//      ^ invalid.illegal.identifier
    id 6
//  ^^ meta.binding.property.qml
//     ^ invalid.illegal
    id /*comment*/ : /**
        */ seven/**/
//         ^^^^^ entity.name.label
//              ^^^^ comment.block
    id: eight; id: nine/**/; id: ten
//           ^ punctuation.terminator.statement
//  ^^^^^^^^^  meta.binding.property.qml
//             ^^^^^^^^ meta.binding.property.qml
//                     ^^^^ comment.block
//                           ^^^^^^^ meta.binding.property.qml
    id: break
//      ^^^^^ invalid.illegal.identifier
}

RequiredProperties {
    required name;; required /**/ text
//  ^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ storage.modifier.required
//           ^^^^ meta.binding.name variable.other.member
//               ^ punctuation.terminator.statement
//                ^^ - meta.binding.property.qml
//                ^ invalid.illegal.unexpected-terminator.qml
//                  ^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//                           ^^^^ comment.block
//                                ^^^^ meta.binding.name variable.other.member
    required Four
//           ^^^^ invalid.illegal.expected-name
    required 5
//           ^ invalid.illegal.expected-name
    required break
//           ^^^^^ invalid.illegal.expected-name
    required prop: 42
//  ^^^^^^^^^^^^^ meta.binding.property.qml
//               ^ punctuation.separator.mapping.key-value.qml invalid.illegal.binding
//                 ^^ meta.number.integer.decimal.js constant.numeric.value.js
    required foo bar
//           ^^^ invalid.illegal.expected-property
    required break;
//           ^^^^^ invalid.illegal.expected-name
/* Apparently, these are valid property names in QML */
    required required
//           ^^^^^^^^ meta.binding.name variable.other.member - invalid.illegal
    required property
//           ^^^^^^^^ meta.binding.name variable.other.member - invalid.illegal
    required property var modelData
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^ storage.type support.other
//                        ^^^^^^^^^ meta.binding.name variable.other.member
    required property varia modelData
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^^^ - storage.type
//                          ^^^^^^^^^ meta.binding.name variable.other.member
    required property variant modelData
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^^^^^ storage.type support.other invalid.deprecated.variant
//                            ^^^^^^^^^ meta.binding.name variable.other.member
    required property int nine;;
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^ storage.type support.type
//                        ^^^^ meta.binding.name variable.other.member
//                            ^ punctuation.terminator.statement.qml
//                             ^ invalid.illegal.unexpected-terminator.qml - meta.binding.property
    required property url ten:
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property
//                           ^ punctuation.separator.mapping.key-value.qml invalid.illegal.binding
        10
//      ^^^ meta.binding.property
//      ^^ meta.number.integer.decimal.js constant.numeric.value.js
    required property list<url> eight
//                    ^^^^ storage.type support.other
//                        ^ punctuation.definition.generic.begin
//                         ^^^ storage.type support.type
//                            ^ punctuation.definition.generic.end
//                              ^^^^^ meta.binding.name variable.other.member
    required property list<Item> seven
//                    ^^^^ storage.type support.other
//                        ^ punctuation.definition.generic.begin
//                         ^^^^ support.class
//                             ^ punctuation.definition.generic.end
//                               ^^^^^ meta.binding.name variable.other.member
    required property list<QtQuick.Item> six
//                    ^^^^ storage.type support.other
//                        ^ punctuation.definition.generic.begin
//                         ^^^^^^^ support.class
//                                ^ punctuation.accessor
//                                 ^^^^ support.class
//                                     ^ punctuation.definition.generic.end
//                                       ^^^ meta.binding.name variable.other.member
    required property what isthis
//                    ^^^^ - storage.type.qml & - support.type
//                         ^^^^^^ meta.binding.name variable.other.member
    required property what for
//                         ^^^ invalid.illegal.expected-identifier.qml
}

RegularProperties {
    property color bright
//  ^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^^ storage.type support.type
//                 ^^^^^^ meta.binding.name variable.other.member
    property color bright;
//  ^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//                       ^ punctuation.terminator.statement
//                        ^ meta.block - meta.binding.property.qml
    property Item child;
//  ^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^ support.class
//                ^^^^^ meta.binding.name variable.other.member
//                     ^ punctuation.terminator.statement
    property QQC2.Button button
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^ support.class
//               ^ punctuation.accessor
//                ^^^^^^ support.class
//                       ^^^^^^ meta.binding.name variable.other.member
    property list<Item> children
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^ storage.type support.other
//               ^ punctuation.definition.generic.begin
//                ^^^^ support.class
//                    ^ punctuation.definition.generic.end
//                      ^^^^^^^^ meta.binding.name variable.other.member
    property alias those: root.background.children
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^^ keyword.other
//                 ^^^^^ meta.binding.name variable.other.member
//                      ^ punctuation.separator.mapping.key-value
//                        ^^^^ variable.other.readwrite.js
//                            ^ punctuation.accessor.js
//                             ^^^^^^^^^^ meta.property.object.js
//                                       ^ punctuation.accessor.js
//                                        ^^^^^^^^ meta.property.object.js
    default property list<QtObject> data
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^ keyword.other.qml storage.modifier.default.qml
//          ^^^^^^^^ keyword.declaration
//                                  ^^^^ meta.binding.name variable.other.member
    readonly property string name: "xyz"
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.other.qml storage.modifier.required.qml
//           ^^^^^^^^ keyword.declaration
//                           ^^^^ meta.binding.name variable.other.member
//                               ^ punctuation.separator.mapping.key-value.qml
//                                 ^^^^^ meta.string string.quoted.double
    property url icon: Qt.application.layoutDirection === Qt.RightToLeft
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.block.qml meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^ storage.type support.type
//               ^^^^ meta.binding.name variable.other.member
//                   ^ punctuation.separator.mapping.key-value.qml
//                     ^^ support.class.js
//                       ^ punctuation.accessor.js
//                        ^^^^^^^^^^^ meta.property.object.js
//                                   ^ punctuation.accessor.js
//                                    ^^^^^^^^^^^^^^^ meta.property.object.js
//                                                    ^^^ keyword.operator.comparison.js
//                                                        ^^ support.class.js
//                                                          ^ punctuation.accessor.js
//                                                           ^^^^^^^^^^^ meta.property.object.js
        ? "go-back-rtl" : "go-back"
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//      ^ keyword.operator.ternary
//        ^^^^^^^^^^^^^ meta.string string.quoted.double
//                      ^ keyword.operator.ternary
//                        ^^^^^^^^^ meta.string string.quoted.double
    property int size: if (cond) { return 1; }
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^ storage.type support.type
//               ^^^^ meta.binding.name variable.other.member
//                   ^ punctuation.separator.mapping.key-value
//                     ^^ meta.conditional.js keyword.control.conditional.if.js
//                        ^^^^^^ meta.conditional.js meta.group.js
//                               ^^^^^^^^^^^^^ meta.conditional.js meta.block.js
//                                 ^^^^^^ keyword.control.flow.return.js
//                                         ^ punctuation.terminator.statement.js
    else if { return 2; } else {}
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.conditional.js
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^ keyword.control.conditional.elseif.js
//          ^^^^^^^^^^^^^ meta.block.js
//                        ^^^^ keyword.control.conditional.else.js
//                             ^^ meta.block.js
    property point mouse:
//  ^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//  ^^^^^^^^ keyword.declaration
//           ^^^^^ storage.type support.type
//                 ^^^^^ meta.binding.name variable.other.member
        Qt.point(null, undefined, NaN)
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.binding.property.qml
//      ^^ meta.function-call.method.js support.class.js
//        ^ meta.function-call.method.js punctuation.accessor.js
//         ^^^^^ meta.function-call.method.js variable.function.js
//               ^^^^ meta.function-call.method.js meta.group.js constant.language.null.js
//                     ^^^^^^^^^ meta.function-call.method.js meta.group.js constant.language.undefined.js
//                                ^^^ meta.function-call.method.js meta.group.js constant.language.nan.js
}
// <- meta.block punctuation.section.block.end
// ^ - meta.block

WithMethods {
    id: withMethods
    function abc(arg1) {}
//  ^^^^^^^^ meta.function keyword.declaration.function
//           ^^^ meta.function entity.name.function
//              ^ meta.function.parameters punctuation.section.group.begin
//               ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                   ^ meta.function.parameters punctuation.section.group.end
//                     ^^ meta.function meta.block
//                       ^ meta.block.qml - meta.function
// make sure statements still work
    required property rect rect
//  ^^^^^^^^ keyword.other storage.modifier.required
//           ^^^^^^^^ keyword.declaration
//                    ^^^^ storage.type support.type
//                         ^^^^ meta.binding.name variable.other.member
    function def(arg2, arg3) {
        const i = 42;
//      ^^^^^ meta.block.qml meta.function meta.block keyword.declaration
//                ^^ meta.block.qml meta.function.js meta.block.js meta.number.integer.decimal.js constant.numeric.value.js
        function () {};
//      ^^^^^^^^ meta.block.qml meta.function meta.block.js meta.function keyword.declaration.function
    }
    function typed(arg4: string, arg5: Item, arg6: QtQuick.Item, { objectName }) {
//                 ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                     ^ meta.function.parameters punctuation.separator.type
//                       ^^^^^^ meta.function.parameters storage.type support.type
//                             ^ meta.function.parameters punctuation.separator.parameter.function
//                               ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                                   ^ meta.function.parameters punctuation.separator.type
//                                     ^^^^ meta.function.parameters support.class
//                                         ^ meta.function.parameters punctuation.separator.parameter.function
//                                           ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                                               ^ meta.function.parameters punctuation.separator.type
//                                                 ^^^^^^^ meta.function.parameters support.class
//                                                        ^ meta.function.parameters punctuation.accessor
//                                                         ^^^^ meta.function.parameters support.class
//                                                             ^ meta.function.parameters punctuation.separator.parameter.function
//                                                                 ^^^^^^^^^^ meta.function.parameters meta.binding.destructuring.mapping meta.mapping.key meta.binding.name variable.parameter.function
        let j = 9001;
//      ^^^ meta.block.qml meta.function.js meta.block.js keyword.declaration.js
    }
    function returns(): string {let i;}
//                    ^ meta.function.js punctuation.separator.type.qml
//                      ^^^^^^ meta.function.js storage.type support.type
//                             ^^^^^^^^ meta.block.qml meta.function.js meta.block.js
//                              ^^^ keyword.declaration.js
}

Signals {
    signal basic1;
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^ meta.function entity.name.function
//               ^ meta.function punctuation.terminator.statement
    signal basic2
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^ meta.function entity.name.function
    signal decorated1();
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^^^^ meta.function entity.name.function
//                   ^ meta.function.parameters punctuation.section.group.begin
//                    ^ meta.function.parameters punctuation.section.group.end
//                     ^ meta.function punctuation.terminator.statement
    signal decorated2()
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^^^^ meta.function entity.name.function
//                   ^ meta.function.parameters punctuation.section.group.begin
//                    ^ meta.function.parameters punctuation.section.group.end
    signal untyped(arg1, arg2: string, arg3)
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^ meta.function entity.name.function
//                ^ meta.function.parameters punctuation.section.group.begin
//                 ^^^^ invalid.illegal.expected-type
//                     ^ meta.function.parameters punctuation.separator.parameter.function
//                       ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                           ^ meta.function.parameters punctuation.separator.type
//                             ^^^^^^ meta.function.parameters storage.type support.type
//                                   ^ meta.function.parameters punctuation.separator.parameter.function
//                                     ^^^^ invalid.illegal.expected-type
//                                         ^ meta.function.parameters punctuation.section.group.end
    signal pressed(arg1: real, arg2: QQC2.Button)
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^ meta.function entity.name.function
//                ^ meta.function.parameters punctuation.section.group.begin
//                 ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                     ^ meta.function.parameters punctuation.separator.type
//                       ^^^^ meta.function.parameters storage.type support.type
//                           ^ meta.function.parameters punctuation.separator.parameter.function
//                             ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                                 ^ meta.function.parameters punctuation.separator.type
//                                   ^^^^ meta.function.parameters support.class
//                                       ^ meta.function.parameters punctuation.accessor
//                                        ^^^^^^ meta.function.parameters support.class
//                                              ^ meta.function.parameters punctuation.section.group.end
    signal clicked(point arg1, size arg2)
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^ meta.function entity.name.function
//                ^ meta.function.parameters punctuation.section.group.begin
//                 ^^^^^ meta.function.parameters storage.type support.type
//                       ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                           ^ meta.function.parameters punctuation.separator.parameter.function
//                             ^^^^ meta.function.parameters storage.type support.type
//                                  ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                                      ^ meta.function.parameters punctuation.section.group.end
    signal hovered(Item arg1, QQC2.Button arg2)
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^^^ meta.function entity.name.function
//                ^ meta.function.parameters punctuation.section.group.begin
//                 ^^^^ meta.function.parameters support.class
//                      ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                          ^ meta.function.parameters punctuation.separator.parameter.function
//                            ^^^^ meta.function.parameters support.class
//                                ^ meta.function.parameters punctuation.accessor
//                                 ^^^^^^ meta.function.parameters support.class
//                                        ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                                            ^ meta.function.parameters punctuation.section.group.end
    signal mixed(url arg1, arg2: bool)
//  ^^^^^^ meta.function keyword.declaration.function
//         ^^^^^ meta.function entity.name.function
//              ^ meta.function.parameters punctuation.section.group.begin
//               ^^^ meta.function.parameters storage.type support.type
//                   ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                       ^ meta.function.parameters punctuation.separator.parameter.function
//                         ^^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                             ^ meta.function.parameters punctuation.separator.type
//                               ^^^^ meta.function.parameters storage.type support.type
//                                   ^ meta.function.parameters punctuation.section.group.end
    signal multiline(url one,
//                   ^^^ meta.function.parameters storage.type support.type
//                       ^^^ meta.function.parameters meta.binding.name variable.parameter.function
//                          ^ meta.function.parameters punctuation.separator.parameter.function
        two   ,
//      ^^^ meta.function.parameters invalid.illegal.expected-type.qml meta.binding.name.js variable.parameter.function.js
//         ^^^^^ - invalid.illegal
//            ^ meta.function.parameters punctuation.separator.parameter.function
        string three url four,
//      ^^^^^^^^^^^^^^^^^^^^^^ meta.function.parameters - invalid.illegal
//      ^^^^^^ storage.type support.type
//             ^^^^^ meta.binding.name variable.parameter.function
//                   ^^^ storage.type support.type
//                       ^^^^ meta.binding.name variable.parameter.function
//                           ^ punctuation.separator.parameter.function
        five,
//      ^^^^^^ meta.function.parameters
//      ^^^^ invalid.illegal.expected-type.qml meta.binding.name.js variable.parameter.function.js
//          ^ punctuation.separator.parameter.function
//          ^^ - invalid.illegal
        six/**/:/**/ var/**/,
//      ^^^^^^^^^^^^^^^^^^^^^^ meta.function.parameters - invalid.illegal
//      ^^^ meta.binding.name variable.parameter.function
//             ^ punctuation.separator.type
//                   ^^^ storage.type support.other
//                          ^ punctuation.separator.parameter.function
        string
//      ^^^^^^ storage.type support.type
//      ^^^^^^^ meta.function.parameters - invalid.illegal
            seven,
//          ^^^^^^^ meta.function.parameters - invalid.illegal
//          ^^^^^ meta.binding.name variable.parameter.function
//               ^ punctuation.separator.parameter.function
        eight:
//      ^^^^^^^ meta.function.parameters - invalid.illegal
//      ^^^^^ meta.binding.name variable.parameter.function
//           ^ punctuation.separator.type
            url,
//          ^^^^^ meta.function.parameters - invalid.illegal
//          ^^^ storage.type support.type
//             ^ punctuation.separator.parameter.function
        nine/**/
//      ^^^^^^^^^ meta.function.parameters - invalid.illegal
//      ^^^^ meta.binding.name variable.parameter.function
//          ^^^^ comment.block
            /**/:/**/
//          ^^^^^^^^^^ meta.function.parameters - invalid.illegal
//          ^^^^ comment.block
//              ^ punctuation.separator.type
//               ^^^^ comment.block
            /**/url,
//          ^^^^^^^^^ meta.function.parameters - invalid.illegal
//          ^^^^ comment.block
//              ^^^ storage.type support.type
//                 ^ punctuation.separator.parameter.function
        url: url,
//      ^^^ meta.binding.name variable.parameter.function
//         ^ punctuation.separator.type
//           ^^^ storage.type support.type
//              ^ punctuation.separator.parameter.function
        url  url,
//      ^^^ storage.type support.type
//           ^^^ meta.binding.name variable.parameter.function
//              ^ punctuation.separator.parameter.function
    )
//  ^ meta.function.parameters punctuation.section.group.end

// <- meta.block.qml meta.function.js
    ;
//  ^ meta.function.js punctuation.terminator.statement.js
//   ^ - meta.function.js punctuation.terminator.statement.js
}

Expressions {
    function multiline_strings() {
        "use
//      ^^^^^ meta.string string.quoted.double
//      ^ punctuation.definition.string.begin
//          ^ invalid.deprecated.newline.qml
        strict";
//      ^^^^^^^ meta.string string.quoted.double
//            ^ punctuation.definition.string.end
//             ^ - meta.string
        const single = 'flip
//                     ^^^^^^ meta.string string.quoted.single
//                     ^ punctuation.definition.string.begin
//                          ^ invalid.deprecated.newline.qml
        flop';
//      ^^^^^ meta.string string.quoted.single
//          ^ punctuation.definition.string.end
        const template = `hip
//                       ^^^^^ meta.string string.quoted.other
//                           ^ - invalid.deprecated.newline.qml
        hop`;
    }
}

// <- - meta.block

InlineComponents {
    component A : Label {}
//  ^^^^^^^^^ keyword.declaration.component
//            ^ entity.name.class
//              ^ punctuation.separator.type
//                ^^^^^ support.class
//                      ^^ meta.block meta.block
//                      ^ punctuation.section.block.begin
//                       ^ punctuation.section.block.end
//  ^^^^^^^^^^^^^^^^^^^^^^ meta.component.qml

// <- - meta.component.qml
    component B : C.D {}
//  ^^^^^^^^^ keyword.declaration.component
//                ^ support.class
//                 ^ punctuation.accessor
//                  ^ support.class
    B {}
//  ^ support.class
    component E : F {};
//                    ^ invalid.illegal.unexpected-terminator.qml
    G {}
//  ^ support.class
}

Handlers {
    onPressed: y = event.y;
//  ^^^^^^^^^^^^^^^^^^^^^^^ meta.handler.qml
//  ^^^^^^^^^ meta.binding.name variable.function
//    ^^^^^^^ markup.underline
//           ^ punctuation.separator.mapping.key-value
//             ^ variable.other.readwrite.js
//               ^ keyword.operator.assignment.js
//                 ^^^^^ variable.other.readwrite.js
//                      ^ punctuation.accessor.js
//                       ^ meta.property.object.js
//                        ^ punctuation.terminator.statement.js
    onWidthChanged: {
//  ^^^^^^^^^^^^^^^^^^ meta.handler.qml
//  ^^^^^^^^^^^^^^ meta.binding.name variable.function
//    ^^^^^ markup.underline
//                ^ punctuation.separator.mapping.key-value
//                  ^^ meta.block.js
        const abc = "xyz";
//      ^^^^^^^^^^^^^^^^^^ meta.handler.qml meta.block.js
//      ^^^^^ keyword.declaration.js
//                  ^^^^^ meta.string string.quoted.double
    };;
//  ^ meta.block.js
//   ^^ invalid.illegal.unexpected-terminator

// TODO: attached handlers
/*Component.*/onCompleted: {}
//            ^^^^^^^^^^^^^^^ meta.handler.qml
//            ^^^^^^^^^^^ meta.binding.name variable.function
//              ^^^^^^^^^ markup.underline

    onEntered: Animation {}
// TODO: objects as binding values
}
