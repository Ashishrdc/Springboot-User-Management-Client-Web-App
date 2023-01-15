// Script for loading the image in the img tag as soon as the user inputs file

const image_input = document.querySelector("#uploadImg");
    var imageResult = "";

    image_input.addEventListener("change", function(){
        const reader = new FileReader();
        reader.addEventListener("load", () => {
            imageResult = reader.result;
            console.log(imageResult.value)
            document.getElementById("profile").src = imageResult;
        });
        reader.readAsDataURL(this.files[0]);
    })

