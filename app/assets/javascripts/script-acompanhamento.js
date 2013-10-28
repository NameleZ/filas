$(document).ready(function () {

    setInterval(obterPosicaoAtual, 10000);
});

function obterPosicaoAtual(){
    console.log($("#hash-fila").val());
    $.ajax({
        url: "/filas/acompanhar_fila",
        data: {
            id: $("#hash-fila").val()
        },
        success: function (data) {
            $(".senha").text(data.posicao);
        }
    });
}