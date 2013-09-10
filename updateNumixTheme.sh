#!/bin/bash

DEBUG=1
THEME_NAME="Numix"
THEME_MODIFICATOR="Blue"
SOURCE_PATH="/usr/share/themes/$THEME_NAME"
TARGET_PATH="$HOME/.themes/$THEME_NAME-$THEME_MODIFICATOR"
SOURCE_COLOR="d64937"
TARGER_COLOR="2F5FA3"

# Check of source path is exist
if [ ! -d $SOURCE_PATH ] ; then
    echo "Error: Source directory $SOURCE_PATH doesn't exist";
    exit 1;
fi

# Copy newest files
if [ $DEBUG -eq 1 ] ; then
    rsync -auv $SOURCE_PATH/ $TARGET_PATH/;
else
    rsync -au $SOURCE_PATH/ $TARGET_PATH/;
fi

# Replace theme name
sed -i "s/=$THEME_NAME$/=$THEME_NAME-$THEME_MODIFICATOR/g" $TARGET_PATH/index.theme

# Replace colors
grep -rl "$SOURCE_COLOR" $TARGET_PATH/* | xargs sed -i "s/$SOURCE_COLOR/$TARGER_COLOR/g"

echo "Done"
exit 0

