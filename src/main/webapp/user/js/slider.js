/*轮播图实现*/

window.onload=function (){
    /*轮播图实现*/

    /*变量声明和定义*/
    let curIndex=0;
    let container=document.getElementsByClassName("slides")[0];
    let slideBox=document.getElementsByClassName("slide-box")[0];
    let imageItems=slideBox.getElementsByTagName("img");

    let dotItems=document.getElementsByClassName("dot-box")[0]
        .getElementsByTagName("li");

    let autoplayTimer;

    /*点击dot切换*/
    for (let i=0;i<dotItems.length;i++){
        dotItems[i].onclick=function (){

            change(i);
        }
    }
    /*自动轮播*/
    slidePlay();
    container.addEventListener("mouseover",function (){
        clearInterval(autoplayTimer);
    });

    container.addEventListener("mouseout",function (){
        slidePlay();
    });


    // 自动轮播函数
    function slidePlay(){
        autoplayTimer=setInterval(function (){
            change(++curIndex);
            // console.log("cur:"+curIndex);
        },5000)    //这个延迟是每张图片停留的时间（包括动画）
    }

    function change(targetIndex){
        //dot相关操作
        for (let j=0;j<dotItems.length;j++){
            dotItems[j].classList.remove("active");
        }
        if (targetIndex==dotItems.length){
            dotItems[0].classList.add("active");
        }
        else {
            dotItems[targetIndex].classList.add("active");
        }

        let movePercent=-(targetIndex*20)+"%";
        slideBox.style.cssText="transform: translateX(" + movePercent + "); transition:1s;";
        curIndex=targetIndex;

        if (curIndex==dotItems.length){
            setTimeout(function (){
                curIndex=0;
                slideBox.style.cssText = "transform: translateX(" + 0 + ");";
            },1000);
        }
    }



}