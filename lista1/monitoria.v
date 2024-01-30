module HelloWorld;
    initial begin
        $display("Hello, World!");
        $finish;
    end
endmodule

$display("Hello, World!"); // Printa na tela
HelloWorld hello(); // Instancia o módulo HelloWorld
$finish; // Finaliza a simulação

// slide: https://docs.google.com/presentation/d/1iB-DjwSbxgapu50q_71sfXN2walTzlVA7FTAg0vkJcY/edit#slide=id.p

// um módulo por arquivo
// um módulo pode ser instanciado em outro módulo
// só pode usar if-else dentro de um bloco procedural (always, initial begin...)
// sempre usar begin-end em blocos procedural
// <= é atribuição, = é comparação
// assign é atribuição contínua e é usado para atribuir valores a fios (wire)
// wire é um fio, reg é um registrador
// atribuição blocking (atribui e espera) e non-blocking (atribui e não espera)
// sempre usar non-blocking em atribuições sequenciais
// sempre usar blocking em atribuições concorrentes
// non blocking só atribui depois que todos os blocos de atribuição forem executados, ou seja, quando chegar no end
// na máquina de estados, sempre usar non-blocking
