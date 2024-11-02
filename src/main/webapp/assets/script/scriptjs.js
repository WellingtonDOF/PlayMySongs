function validarCaracter()
{
    var nomeM = document.getElementById("music").value;
    var cantorM = document.getElementById("singer").value;
    var arq= document.getElementById("arq").value;
    //letras de a, z minusculas, A, Z maisculas, numeros 0-9, sublinhado _ e \s que é espaço em branco
    var regex = /^[a-zA-Z0-9_\s]*$/;

    if(!regex.test(nomeM) || !regex.test(cantorM) || nomeM=="" || cantorM=="" || arq=="")
    {
        alert("Caracter especial/Arquivo inválido, tente novamente.");
        //colocar os valores para " NULO " para verificar no servlet e fazer o upload
        document.getElementById("music").value="";
        document.getElementById("singer").value="";
        return false;
    }
    alert("Arquivo enviado para MUSIC!");
    return true;
}