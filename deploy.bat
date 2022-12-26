SET FIRMVER=3.0.4
call asciidoctor-pdf ion.adoc -D  '%FIRMVER%' --theme my-theme.yml -a scripts=cjk -r asciidoctor-diagram -r ./mylib.rb
call asciidoctor ion.adoc -o index.html -D '%FIRMVER%' -a toc=left -r asciidoctor-diagram -r ./mylib.rb -a imagesdir=image -a imagesoutdir='%FIRMVER%/image' -a diagram-format=svg -a diagram-svg-type=inline
rd /s /q "%FIRMVER%\image"
xcopy /Y /S /E image\ion "%FIRMVER%/image\ion\"
rd /s /q "%FIRMVER%\.asciidoctor"
