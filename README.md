# 107_1_AssemblyLanguage_Final
107-1 組合語言 期末專案

> 老師：朱守禮  
> 組別：第九組  
> 班級：資訊二甲  
> 學生：10627109  陳力維  
> 學生：10627110  王昱凱  
> 學生：10627150  林易賢  

## 背景
主程式MAIN包含兩個函數：NAME, ID，共同構成一個能列印組別、組員名字、與學號，並完成學號加總運算的專案。所有程式均需以ARM Assembly完成。  
程式需符合「Project基本要求」：
- 使用 Midterm Project 的 2 個函數：NAME, ID，並分別存放於 name.s 與 id.s 檔案 內。 
- 以 ARM 組合語言重新撰寫計算 Julia Set 的函數：drawJuliaSet，並存放於 drawJuliaSet.s 檔案裡。
- drawJuliaSet 函數之 ARM 組合語言程式，需滿足以下三個項目：
  - 使用 Data Processing 指令中，13 種 Operand2 格式的當中 4 種以上。
  - 包含3道以上的非Branch指令的Conditional Execution （不包括AL或”不指定” 條件）。
  - 包括 1 道一定要執行的指令：sbcs r11, r0, r1。
## 方法
- name.s  
asciz規劃記憶體空間，把需要印出的字串放入。用`label`指向該記憶體位置，以虛擬指令`ldr  r0, =label` 將位置load到`r0`內，然後再呼叫`printf`印出字串，重複此步驟至所有要求內容印完。
- id.s  
asciz規劃記憶體空間，把需要印出的字串放入。用`label`指向該記憶體位置，以虛擬指令`ldr  r0, =label` 將位置load到`r0`內，然後再呼叫`printf`印出字串，重複此步驟至所有要求內容印完。用`scanf`與`printf`前給一個像是`%d`、`%s`等的型別，再給一個記憶體位置，這樣才能順利`scanf`或`printf`，另外，`scanf`後,再將位置的值assign給暫存器，供後來要用的時候可以用。在呼叫`add`的時候，欲相加的兩個暫存器所存放的值應為數字而不是位置。
- drawJuliaSet.s  
依照老師給的範本C code改寫成assembly，我們把所有變數都放在sp裡，每次取值就得用ldr這個指令從sp裡需要的變數出來做運算，這樣的方式可以很大程度的節省暫存器的使用，由於清楚變數怎麼存放，所以Debug可以很輕鬆。
- main.s  
整合上述三函式功能，用extern告知有上述三函式以及各個變數，這樣在印出名字學號時可以直接call那個變數名字，很方便。   
![image](https://user-images.githubusercontent.com/51331397/183277653-db6dc217-831e-4e8a-861d-53024e44bbe6.png)  
![image](https://user-images.githubusercontent.com/51331397/183277663-6808943f-2d26-4dd6-b34a-385e262266a5.png)  

## 結果（程式驗證結果）
![image](https://user-images.githubusercontent.com/51331397/183277716-24a56988-a5c0-44a4-a1c5-8e02ebdecded.png)  
![image](https://user-images.githubusercontent.com/51331397/183277721-0d37c1cc-c104-408c-9dd9-8b306896f841.png)  
![image](https://user-images.githubusercontent.com/51331397/183277727-e6329751-0952-4ac0-a1d2-3858b8f09434.png)  
![image](https://user-images.githubusercontent.com/51331397/183277731-ab70bc7f-7973-4881-a76f-96f1cc9f16f9.png)  

## 討論
### name.s  
組別編號(“Team 09\n”)放置在起始位址`0x112ee`，結束位址`0x112f5`。  
![image](https://user-images.githubusercontent.com/51331397/183277793-4f26f96a-c892-4d1e-b802-cad719a36932.png)  
第一位組員名字(“Chen Li Wei\n”)放置在起始位址`0x112f7`，結束位址`0x11302`。  
![image](https://user-images.githubusercontent.com/51331397/183277808-f1aea8a5-450a-414a-b835-41b294d11b4a.png)  
第二位組員名字(“Wong Yu Kai\n”)放置在起始位址`0x11304`，結束位址`0x1130f`。  
![image](https://user-images.githubusercontent.com/51331397/183277819-d4f87e04-902b-4798-b3aa-de74e5a9fbb5.png)  
第三位組員名字(“Lin Yi Xian\n”)放置在起始位址`0x11311`，結束位址`0x1131c`。  
![image](https://user-images.githubusercontent.com/51331397/183277834-ea3e42ac-c87e-4987-9f68-8b7fc160a3e0.png)  

### id.s  
第一位組員學號(10627109 0x00a22825)放置在起始位址`0x111d5`，結束位址`0x111d8`。  
![image](https://user-images.githubusercontent.com/51331397/183277883-899ba39b-b6b0-4a27-9e61-57f684cd3cd1.png)  
第二位組員學號(10627110 0x00a22826)放置在起始位址`0x111d9`，結束位址`0x111dc`。  
![image](https://user-images.githubusercontent.com/51331397/183277902-29fadd9a-dc7e-46bd-b609-a8d8635c41b4.png)  
第三位組員學號(10627150 0x00a2284e)放置在起始位址`0x111dd`，結束位址`0x111e0`。  
![image](https://user-images.githubusercontent.com/51331397/183277912-20f9e80b-0f68-47d5-bab8-07e4b3e2279b.png)  
學號總和(31881369 0x01e67899)放置在起始位址`0x111d1`，結束位址`0x111d4`。  
![image](https://user-images.githubusercontent.com/51331397/183277919-fe5d949f-12d0-4c01-a8b4-054e960fa896.png)  

### drawJuliaSet.s  
- 呼叫此函式前，caller分配記憶體空間給此函式使用。執行此函式時，`frame`為pointer，初始指向caller分配的記憶體最底，位址為`0xbef694a8`。  
![image](https://user-images.githubusercontent.com/51331397/183278082-d61dd0f9-31fc-4bc7-a5ae-4151b364a99a.png)  
- 將二維陣列轉為一維陣列儲存，每個2-byte大小的數字儲存位置依照公式![](http://latex.codecogs.com/svg.latex?1280y + 2x(0\lq))，

### main.s  
如下圖，name函式的記憶體位置為`0x865c`，執行name函式時返回位置為暫存器`lr`所記錄，值為`0x85a8`，暫存器`pc`所存的位置`0x8660`為執行name函式後下一個欲執行指令的位置。
![image](https://user-images.githubusercontent.com/51331397/183242913-118d4fd5-131b-4288-a81d-a45f1fa20e71.png)  
如下圖，id函式的記憶體位置為`0x8450`，執行id函式時返回位置為暫存器`lr`所記錄，值為`0x85b8`，暫存器`pc`所存的位置`0x8454`為執行id函式後下一個欲執行指令的位置。
![image](https://user-images.githubusercontent.com/51331397/183242957-cb11efd0-4f48-4c9a-9bce-398ed6c6b3df.png)  

## 結論
開始寫project前，我們對於組合語言的認識還是一知半解，考試也都考爛爛的，對於各種指令在做甚麼都不是很了解，在寫此次作業的過程中，撞了不少牆，常常因為語法不熟悉而想法與寫出來的結果不一樣，卡了好幾小時，後來經摸索與詢問同學，逐漸對語法更加熟捻，才能完成作業。

## 未來展望
經過這次其中project的洗禮，我們對組合語言有更進一步的認識，像是使code block Debug模式去觀察register與記憶體的內容變化，透過這個方式我們對組合語言部分只有更加直觀的認識，希望在期末project可以更加的熟悉組合語言的指令，以期以後能以組合語言實現曾寫之C程式。
