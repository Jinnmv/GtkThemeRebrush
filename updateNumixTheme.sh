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
    echo    "*** Debug information ***"
    echo    "  Source theme path: $SOURCE_PATH"
    echo -e "  Theme name:        $THEME_NAME\n"
    echo    "  Target path:       $TARGET_PATH"
    echo -e "  Theme modificator: $THEME_MODIFICATOR\n"
    echo "  Replace color:    $SOURCE_COLOR"
    echo -e "  Target color:     $TARGER_COLOR\n"
fi

# Check of source path is exist
if [ $DEBUG -eq 1 ] ; then
    echo -e "DEBUG: Checking of source path $SOURCE_PATH\n"
fi

if [ ! -d $SOURCE_PATH ] ; then
    echo "Error: Source directory $SOURCE_PATH doesn't exist";
    exit 1;
fi

# Copy newest files
if [ $DEBUG -eq 1 ] ; then
    echo -e "DEBUG: Copying new files"
    echo -e "       $SOURCE_PATH -> $TARGET_PATH\n"
    rsync -auv $SOURCE_PATH/ $TARGET_PATH/;
else
    rsync -au $SOURCE_PATH/ $TARGET_PATH/;
fi

# Replace theme name
if [ $DEBUG -eq 1 ] ; then
    echo -e "\nDEBUG: Altering theme name '$THEME_NAME' -> '$THEME_NAME-$THEME_MODIFICATOR'"
    echo "       in file $TARGET_PATH/index.theme"
fi
sed -i "s/=$THEME_NAME$/=$THEME_NAME-$THEME_MODIFICATOR/g" $TARGET_PATH/index.theme

# Replace colors
if [ $DEBUG -eq 1 ] ; then
    echo -e "\nDEBUG: Replacing color #$SOURCE_COLOR -> #$TARGER_COLOR\n"
fi
grep -rl "$SOURCE_COLOR" $TARGET_PATH/* | xargs sed -i "s/$SOURCE_COLOR/$TARGER_COLOR/g"

echo ""
echo "Done"
exit 0

