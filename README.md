# 異音チェッカー 取扱説明書 管理

- ion.adoc で管理
- asciidoctor-pdf で PDF出力
-   
  ```mermaid
  graph LR
    asciidoc --> |asciidoctor| docbook
    docbook --> |pandoc| docxその他
  ```
