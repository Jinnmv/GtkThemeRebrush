#!/bin/bash

DEBUG=1
THEME_NAME="Numix"
THEME_MODIFICATOR="Blue"
SOURCE_PATH="/usr/share/themes/$THEME_NAME"
TARGET_PATH="$HOME/.themes/$THEME_NAME-$THEME_MODIFICATOR"
SOURCE_COLOR="d64937"
TARGER_COLOR="2F5FA3"

# Debug info
if [ $DEBUG -eq 1 ] ; then
    echo "*** Debug information ***"
    echo "  Source theme path: $SOURCE_PATH"
    echo "  Theme name:        $THEME_NAME"
    echo ""
    echo "  Target path:       $TARGET_PATH"
    echo "  Theme modificator: $THEME_MODIFICATOR"
    echo ""
    echo "  Replace color:    $SOURCE_COLOR"
    echo "  Target color:     $TARGER_COLOR"
    echo ""
fi

# Check of source path is exist
if [ $DEBUG -eq 1 ] ; then
    echo "DEBUG: Checking of source path $SOURCE_PATH"
    echo ""
fi

if [ ! -d $SOURCE_PATH ] ; then
    echo "Error: Source directory $SOURCE_PATH doesn't exist";
    echo ""
    exit 1;
fi

# Copy newest files
if [ $DEBUG -eq 1 ] ; then
    echo "DEBUG: Copying new files\n$SOURCE_PATH -> $TARGET_PATH"
    echo ""
    rsync -auv $SOURCE_PATH/ $TARGET_PATH/;
else
    rsync -au $SOURCE_PATH/ $TARGET_PATH/;
fi

# Replace theme name
if [ $DEBUG -eq 1 ] ; then
    echo ""
    echo "DEBUG: Altering theme name '$THEME_NAME' -> '$THEME_NAME-$THEME_MODIFICATOR'"
    echo "       in file $TARGET_PATH/index.theme"
fi
sed -i "s/=$THEME_NAME$/=$THEME_NAME-$THEME_MODIFICATOR/g" $TARGET_PATH/index.theme

# Replace colors
if [ $DEBUG -eq 1 ] ; then
    echo ""
    echo "DEBUG: Replacing color #$SOURCE_COLOR -> #$TARGER_COLOR"
    echo ""
fi
grep -rl "$SOURCE_COLOR" $TARGET_PATH/* | xargs sed -i "s/$SOURCE_COLOR/$TARGER_COLOR/g"

echo ""
echo "Done"
exit 0

