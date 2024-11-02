package unoeste.fipp.playmysongs;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import static java.lang.System.out;

@MultipartConfig(
        location="/",
        fileSizeThreshold=1024*1024,    // 1MB *
        maxFileSize=1024*1024*100,      // 100MB **
        maxRequestSize=1024*1024*10*10  // 100MB ***
)

@WebServlet(name = "uploadServlet", value = "/upload-servlet")
public class UploadServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String nomeM, cantorM,estiloM, concatM;
        nomeM=request.getParameter("nomeM");
        cantorM=request.getParameter("cantorM");
        estiloM=request.getParameter("estilos");

        // se valores setados forem "NULOS" é porque o js invalidou, então não mandar pra pasta

        if(nomeM.isEmpty() || cantorM.isEmpty())
            response.sendRedirect("enviamusica.jsp");
        else
        {
            nomeM=tirarEspaco(nomeM);
            cantorM=tirarEspaco(cantorM);
            estiloM=tirarEspaco(estiloM);
            concatM= nomeM+"_"+estiloM+"_"+cantorM+".";
            PrintWriter writer = response.getWriter();
            try
            {
                // lê a pasta de destino
                Part filePart = request.getPart("arq");
                String pasta = "music";
                concatM=concatM+extensaoArq(filePart.getSubmittedFileName());

                String fileName = concatM;
                OutputStream out = null;
                InputStream filecontent = null;
                //criando a pasta

                File fpasta = new File(getServletContext().getRealPath("/") + "/" + pasta);
                fpasta.mkdir();

                out = new FileOutputStream(new File(fpasta.getAbsolutePath() + "/" + fileName));

                filecontent = filePart.getInputStream();

                int read = 0;
                byte[] bytes = new byte[1024];
                while ((read = filecontent.read(bytes)) != -1) {
                    out.write(bytes, 0, read);
                }
                out.close();
                filecontent.close();
            }catch (Exception fne)
            {out.print(fne.getMessage());}
            response.sendRedirect("enviamusica.jsp");
        }
    }
    private String tirarEspaco(String texto)
    {
        return texto.replaceAll("\\s","");
    }

    private String extensaoArq(String extensao)
    {
         int lastIndex = extensao.lastIndexOf(".");
         return  extensao.substring(lastIndex + 1);
    }
}