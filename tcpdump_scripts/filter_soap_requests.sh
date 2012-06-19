#!/bin/bash
sed -n '/<[a-zA-Z:-]*Envelope/,/<\/[a-zA-Z].*:Envelope>/ p' $@

