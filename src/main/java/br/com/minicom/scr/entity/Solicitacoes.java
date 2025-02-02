package br.com.minicom.scr.entity;


import br.com.minicom.scr.cell.Cell;
import br.com.minicom.scr.cell.Type;
import  br.com.minicom.scr.persistence.Entity;

public class Solicitacoes implements Entity {
	private final String DB = "SisCentralRel";
	private final String TABLENAME = "Solicitacoes";
	private final String[] COLUMNNAMES = {"id_solicitacao", "Qtde_tentativas", "Dt_ult_tentativa", "Dt_agenda", "em_chamado", "contato_ok", "PID_cod_pid", "servico_id_servico"};
	private Cell[] values = new Cell[this.COLUMNNAMES.length];

	public Solicitacoes() {
		values[0] = new Cell(true, true,Type.NUM, 0, true);
		values[1] = new Cell(Type.NUM, 0, false);
		values[2] = new Cell(Type.DATE, null, true);
		values[3] = new Cell(Type.DATE, null, false);
		values[4] = new Cell(Type.NUM, 0, false);
		values[5] = new Cell(Type.NUM, 0, false);
		values[6] = new Cell(Type.NUM, 0, true);
		values[7] = new Cell(Type.NUM, 0, true);
	}

	public void setIdSolicitacao(int idSolicitacao) {
		this.values[0].setValue(idSolicitacao);
	}
	public void setQtdeTentativas(int QtdeTentativas) {
		this.values[1].setValue(QtdeTentativas);
	}
	public void setUltTentativa(String ultTentativa) {
		this.values[2].setValue(ultTentativa);
	}
	public void setDtAgenda(String DtAgenda) {
		this.values[3].setValue(DtAgenda);
	}
	public void setEmChamado(int emChamado) {
		this.values[4].setValue(emChamado);
	}
	public void setContatoOk(int contatoOk) {
		this.values[5].setValue(contatoOk);
	}
	public void setCodPid(int codPid) {
		this.values[6].setValue(codPid);
	}
	public void setIdServico(int idServico) {
		this.values[7].setValue(idServico);
	}

	@Override
	public String getDB() {
		return this.DB;
	}

	@Override
	public String getTableName() {
		return this.TABLENAME;
	}

	@Override
	public int getNumOfColumns() {
		return this.COLUMNNAMES.length;
	}

	@Override
	public String getColumnName(int index) throws ArrayIndexOutOfBoundsException {
		if (index >= this.COLUMNNAMES.length || index < 0) {
			throw new ArrayIndexOutOfBoundsException("Indice inserido esta fora do intervalo.");
		}
	return this.COLUMNNAMES[index];
	}

	@Override
	public Cell getCell(int index) throws ArrayIndexOutOfBoundsException {
		if (index >= this.COLUMNNAMES.length || index < 0) {
			throw new ArrayIndexOutOfBoundsException("Indice inserido esta fora do intervalo.");
		}
	return values[index];
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < getNumOfColumns(); i++) {
			sb.append(getColumnName(i)).append('\t');
		}
	sb.append('\n');
	for (int i = 0; i < getNumOfColumns(); i++) {
		sb.append(this.values[i].getValue()).append('\t');
	}
	return sb.toString();
	}
@Override
    public void setCell(int index, Object v) throws ArrayIndexOutOfBoundsException {
        if (index >= this.COLUMNNAMES.length || index < 0) {
            throw new ArrayIndexOutOfBoundsException("Indice inserido esta fora do intervalo.");
        }
        this.values[index].setValue(v);
    }}