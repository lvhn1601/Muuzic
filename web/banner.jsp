<%-- 
    Document   : banner
    Created on : Jul 7, 2023, 9:36:32 PM
    Author     : lvhn1
--%>

<style>
    .slider{
        width: 100%;
        height: 300px;
        border-radius: 10px;
        overflow: hidden;
        position: relative;
    }

    .slides{
        width: 500%;
        height: 100%;
        display: flex;
    }

    .slides input{
        display: none;
    }

    .slide{
        width: 20%;
        transition: 2s;
    }

    .slide img{
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .slide-title {
        font-size: 30px; 
        color: white; 
        position: absolute;
        left: 2%;
        bottom: 5%;
        text-shadow: 2px 2px 8px #303030;
    }

    .navigation-manual{
        position: absolute;
        width: 100%;
        margin-top: -40px;
        display: flex;
        justify-content: center;
    }

    .manual-btn{
        border: 2px solid white;
        padding: 5px;
        border-radius: 10px;
        cursor: pointer;
        transition: 1s;
    }

    .manual-btn:not(:last-child){
        margin-right: 40px;
    }

    .manual-btn:hover{
        background: white;
    }

    #radio1:checked ~ .first{
        margin-left: 0;
    }

    #radio2:checked ~ .first{
        margin-left: -20%;
    }

    #radio3:checked ~ .first{
        margin-left: -40%;
    }

    #radio4:checked ~ .first{
        margin-left: -60%;
    }

    /*css for automatic navigation*/

    .navigation-auto{
        position: absolute;
        display: flex;
        width: 100%;
        justify-content: center;
        margin-top: 260px;
    }

    .navigation-auto div{
        border: 2px solid white;
        padding: 5px;
        border-radius: 10px;
        transition: 1s;
    }

    .navigation-auto div:not(:last-child){
        margin-right: 40px;
    }

    #radio1:checked ~ .navigation-auto .auto-btn1{
        background: white;
    }

    #radio2:checked ~ .navigation-auto .auto-btn2{
        background: white;
    }

    #radio3:checked ~ .navigation-auto .auto-btn3{
        background: white;
    }

    #radio4:checked ~ .navigation-auto .auto-btn4{
        background: white;
    }

</style>

<div class="slider">
    <div class="slides">

        <input type="radio" name="radio-btn" id="radio1" hidden>
        <input type="radio" name="radio-btn" id="radio2" hidden>
        <input type="radio" name="radio-btn" id="radio3" hidden>
        <input type="radio" name="radio-btn" id="radio4" hidden>


        <div class="slide first">
            <img src="test/1.jpg" alt="">
        </div>
        <div class="slide">
            <img src="test/2.jpg" alt="">
        </div>
        <div class="slide">
            <img src="test/3.jpg" alt="">
        </div>
        <div class="slide">
            <img src="test/4.jpg" alt="">
        </div>


        <div class="navigation-auto">
            <div class="auto-btn1"></div>
            <div class="auto-btn2"></div>
            <div class="auto-btn3"></div>
            <div class="auto-btn4"></div>
        </div>

    </div>

    <div class="navigation-manual">
        <label for="radio1" class="manual-btn"></label>
        <label for="radio2" class="manual-btn"></label>
        <label for="radio3" class="manual-btn"></label>
        <label for="radio4" class="manual-btn"></label>
    </div>
    <h2 class="slide-title">Announcement</h2>
</div>


<script type="text/javascript">
    var counter = 1;
    setInterval(function () {
        document.getElementById('radio' + counter).checked = true;
        counter++;
        if (counter > 4) {
            counter = 1;
        }
    }, 5000);
</script>
