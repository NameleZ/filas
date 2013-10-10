$(document).ready(function () {

    $(".up").on("click", function () {
        $(".senha-atual").text(parseInt($(".senha-atual").text()) + 1);
        atualizarSenha();
    });

    $(".down").on("click", function () {
        $(".senha-atual").text(parseInt($(".senha-atual").text()) - 1);
        atualizarSenha();
    });

    $(".senha-atual").on("keyup", function () {
        atualizarSenha();
    });
});

function atualizarSenha(){

    $.ajax({
        url: "/filas/atualizar_senha",
        data: {
            id: $("#id-fila").val(),
            posicao_atual: $(".senha-atual").text()
        },
        success: function (data) {
        }
    });
}