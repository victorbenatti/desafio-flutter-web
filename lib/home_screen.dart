import 'login_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> attachedFiles = []; // Arquivos anexados
  List<String> historyFiles = []; // Histórico de arquivos

  // Selecionar arquivos
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        attachedFiles
            .add(result.files.single.name); // Add o nome do arquivo à lista
      });
    }
  }

  // Limpar anexos
  void _clearAttachments() {
    setState(() {
      historyFiles.addAll(attachedFiles); // Salva no histórico antes de limpar
      attachedFiles.clear(); // Remove todos os arquivos da lista
    });
  }

  // Remover do histórico
  void _removeFromHistory(String fileName) {
    setState(() {
      historyFiles.remove(fileName); // Remove apenas do histórico
    });
  }

  // Restaurar arquivos
  void _restoreFile(String fileName) {
    setState(() {
      attachedFiles.add(fileName); // Add novamente à lista 
      historyFiles.remove(fileName); // Remove permanentemente 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          "👋 Bem vindo(a)",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              // Null (perfil do usuário sem funcionalidade)
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              // Confirmação de logoff
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Sair"),
                  content: const Text("Tem certeza que deseja sair?"),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context), // Fecha a box de diálogo
                      child: const Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text("Sair",
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Menu lateral
          Container(
            width: 200,
            color: Colors.blue.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMenuItem(Icons.attach_file, "Anexar arquivos"),
                _buildMenuItem(Icons.history, "Ver histórico"),
                _buildMenuItem(Icons.settings, "Configurações"),
              ],
            ),
          ),

          // Conteúdo principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildUploadSection()), // Upload
                      const SizedBox(width: 20),
                      Expanded(flex: 3, child: _buildAttachedFiles()), // Anexos
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildHistorySection(), // Histórico
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Menu Lateral
  Widget _buildMenuItem(IconData icon, String text) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black54),
          title: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const Divider(color: Colors.grey), // Separação por linha
      ],
    );
  }

  // Box de upload
  Widget _buildUploadSection() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _pickFile, // Chama a função de seleção de arquivos ao clicar
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const Icon(Icons.add, size: 40, color: Colors.grey),
              const SizedBox(height: 10),
              const Text("Clique aqui para anexar um arquivo",
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }

  // Lista de arquivos anexados
  Widget _buildAttachedFiles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Itens anexados",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),

        attachedFiles.isEmpty
            ? const Text("Nenhum arquivo anexado",
                style: TextStyle(color: Colors.grey))
            : Column(
                children:
                    attachedFiles.map((file) => _buildFileItem(file)).toList(),
              ),

        const SizedBox(height: 20),

        // Botões
        Row(
          children: [
            ElevatedButton(
              onPressed: attachedFiles.isEmpty
                  ? null
                  : _clearAttachments, // Desativa o botão se não houver anexos
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: const Text("Limpar anexos",
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {}, 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child:
                  const Text("Enviar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }

  // Histórico
  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Itens anexados anteriormente",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        historyFiles.isEmpty
            ? const Text("Nenhum histórico de anexos",
                style: TextStyle(color: Colors.grey))
            : Wrap(
                spacing: 10,
                runSpacing: 10,
                children: historyFiles
                    .map((file) => _buildHistoryFileItem(file))
                    .toList(),
              ),
      ],
    );
  }

  // Arquivo no histórico (layout)
  Widget _buildHistoryFileItem(String fileName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.insert_drive_file,
              size: 18, color: Colors.blueAccent),
          const SizedBox(width: 5),
          Text(fileName),
          IconButton(
            icon: const Icon(Icons.restore, color: Colors.green, size: 18),
            onPressed: () {
              setState(() {
                _restoreFile(fileName);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red, size: 18),
            onPressed: () {
              setState(() {
                _removeFromHistory(fileName);
              });
            },
          )
        ],
      ),
    );
  }

  // Layout exibição de arquivos
  Widget _buildFileItem(String fileName, {bool isHistory = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.attach_file, size: 20, color: Colors.blueAccent),
              const SizedBox(width: 8),
              Text(fileName, style: const TextStyle(fontSize: 16)),
            ],
          ),

          Row(
            children: [
              // Botão de restaurar se o arquivo estiver no histórico
              if (isHistory)
                IconButton(
                  icon: const Icon(Icons.restore, color: Colors.green),
                  onPressed: () {
                    setState(() {
                      _restoreFile(fileName);
                    });
                  },
                ),

              // Botão de excluir
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    if (isHistory) {
                      _removeFromHistory(
                          fileName); // Excluir do histórico permanentemente
                    } else {
                      historyFiles.add(
                          fileName); // Adicionar ao histórico antes de remover
                      attachedFiles
                          .remove(fileName); // Remover da lista de anexados
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
