import pandas as pd
import glob
import os
from itertools import combinations

def load_trend_csv(filepath):
    df = pd.read_csv(filepath, skiprows=2, header=None, names=['date', 'value'])
    # Filtra solo filas donde 'date' tiene formato de fecha válido (YYYY-MM-DD)
    df = df[df['date'].str.match(r'\d{4}-\d{2}-\d{2}', na=False)]
    df['date'] = pd.to_datetime(df['date'], format='%Y-%m-%d')
    df['value'] = pd.to_numeric(df['value'], errors='coerce').fillna(0)
    return df

def main(csv_dir):
    files = glob.glob(os.path.join(csv_dir, "*.csv"))
    trend_frames = []
    keywords = []

    for f in files:
        keyword = os.path.splitext(os.path.basename(f))[0]
        keywords.append(keyword)
        df = load_trend_csv(f)
        df = df.rename(columns={'value': keyword})
        trend_frames.append(df.set_index('date'))

    trends = pd.concat(trend_frames, axis=1)
    trends = trends.fillna(0)

    corr_matrix = trends.corr(method='pearson')
    print("Matriz de correlación de Pearson:")
    print(corr_matrix)
    print()

    trafico_kw = pd.read_csv('/Users/adidale/Programs/uni/data_analysis/keyword_list.csv', index_col=0)
    if isinstance(trafico_kw, pd.DataFrame):
        trafico_kw = trafico_kw.iloc[:,0]
    # Keyword List must match exactly the columns in corr_matrix
    matrix_keywords = set(corr_matrix.columns)
    trafico_keywords = set(trafico_kw.index)

    valid_keywords = sorted(list(matrix_keywords & trafico_keywords))
    skipped_matrix = sorted(list(trafico_keywords - matrix_keywords))
    skipped_trafico = sorted(list(matrix_keywords - trafico_keywords))

    if skipped_matrix:
        print(f"Advertencia: estas keywords están en keyword_list.csv pero NO en la matriz de correlación y serán ignoradas:\n{skipped_matrix}\n")
    if skipped_trafico:
        print(f"Advertencia: estas keywords están en la matriz de correlación pero NO en keyword_list.csv y serán ignoradas:\n{skipped_trafico}\n")
    if not valid_keywords:
        print("¡ERROR! No existen keywords en común entre tu CSV de tráfico y los CSVs de trends. Verifica los nombres.")
        return

    trafico_total_bruto = trafico_kw[valid_keywords].sum()

    ajuste_solapamiento = 0
    for kw1, kw2 in combinations(valid_keywords, 2):
        correl = corr_matrix.loc[kw1, kw2]
        minimo = min(trafico_kw[kw1], trafico_kw[kw2])
        ajuste_solapamiento += correl * minimo

    trafico_total_ajustado = trafico_total_bruto - ajuste_solapamiento

    print(f'Keywords usadas para el cálculo: {valid_keywords}\n')
    print(f'Tráfico total sin ajustar (simple suma): {trafico_total_bruto}')
    print(f'Ajuste por solapamiento: {ajuste_solapamiento:.2f}')
    print(f'Tráfico total estimado ajustado: {trafico_total_ajustado:.2f}')

if __name__ == "__main__":
    # Cambia el path por el directorio donde guardas tus CSV
    main("/Users/adidale/Programs/uni/data_analysis")