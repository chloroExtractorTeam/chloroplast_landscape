#!/bin/bash

cp ${1} ${1}_backup

bgzip ${1}
tabix -p vcf ${1}.gz

mv ${1}_backup ${1}
